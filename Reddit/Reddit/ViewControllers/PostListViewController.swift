//
//  PostListViewController.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit

class PostListViewController: UIViewController {
    var posts: [Post] = []
    
    private var subreddit = "r/ios"
    private let tableView = UITableView()
    private var lastPost: String = ""
    private var isLoadingPosts = false
    private var allFound = false
    private var isListSavedMode = false {
        willSet {
            if newValue {
                self.bookmarkButton.tintColor = .systemYellow
                self.bookmarkButton.image = UIImage(systemName: "bookmark.fill")
                
            } else {
                self.bookmarkButton.tintColor = .secondaryLabel
                self.bookmarkButton.image = UIImage(systemName: "bookmark")
            }
        }
    }
    
    private let bookmarkButton: UIBarButtonItem = {
        let bookmarkButton = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: nil,
            action: #selector(didChangeSavedState)
        )
        bookmarkButton.tintColor = .secondaryLabel
        return bookmarkButton
    }()
    
    private let fileManager = FileManager.default
    
    private let searchController = UISearchController(searchResultsController: nil)

    struct Const {
        static let cellIdentifier = "PostTableViewCell"
        static let headerIdentifier = "CustomHeaderView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadPosts()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        print("Total loaded posts: \(posts.count)")
        tableView.reloadData()
    }
    
    private func setupTableView() {
        
        searchController.searchBar.placeholder = "Search.."
        searchController.searchBar.searchTextField.returnKeyType = .search
//        searchController.delegate = self
        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
        
        view.backgroundColor = UIColor.systemBackground
        
        self.title = "r/ios"
        self.bookmarkButton.target = self
        self.navigationItem.rightBarButtonItem = bookmarkButton
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: Const.cellIdentifier)
//        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: Const.headerIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func loadPosts(after: String = "") {
        Task {
            
            let newPosts = await getPostData(subreddit: subreddit, limit: 15, after: after) ?? [Post.mock()]
            
            guard newPosts.count != 0 else {
                allFound = true
                return
            }

            self.posts.append(contentsOf: newPosts)
            
            await MainActor.run {
                self.tableView.reloadData()
                self.lastPost = self.posts.last?.name ?? "nil"
                self.isLoadingPosts = false
            }
        }
    }
}

// MARK: isListSavedMode selector
extension PostListViewController {
    @objc func didChangeSavedState() {
        isListSavedMode.toggle()
        print("Only favorite mode: \(isListSavedMode)")
        if isListSavedMode {
            posts = PersistenceManager.shared.getPosts()
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.tableView.reloadData()
                self.lastPost = self.posts.last?.name ?? "nil"
                self.isLoadingPosts = false
                navigationItem.searchController = searchController
            
            }
        } else {
            self.posts = []
            DispatchQueue.main.async { [weak self] in
                self?.navigationItem.searchController = nil
            }
            self.loadPosts()
        }
    }
}

// MARK: UITableViewDataSource
extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        cell.configure(post: post)
        
        cell.postView.delegate = self
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension PostListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.indexPathsForVisibleRows?
            .contains(where: { $0.row == self.posts.count - 3 }) == true
            && !isLoadingPosts
            && !allFound 
            && !isListSavedMode {
            isLoadingPosts = true
            loadPosts(after: lastPost)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = PostDetailsViewController()
//        vc.configure(post: posts[indexPath.row])
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        let post = posts[indexPath.row]
//        PersistenceManager.shared.togglePostSave(post)
//        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
}

// MARK: PostViewDelegate
extension PostListViewController: PostViewDelegate {
    func didTapCommentButton(for post: Post) {
        let vc = PostDetailsViewController()
        vc.configure(post: post)

        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    func didTapShareButton(for post: Post) {
        let ac = UIActivityViewController(activityItems: [post.postURL], applicationActivities: nil)
        present(ac, animated: true)
    }
    
//    func didTapFavoriteButton(for post: Post) {
//        PersistenceManager.shared.togglePostSave(post)
//    }
}

// MARK: UISearchResultsUpdating
extension PostListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        if searchText.isEmpty {
            self.posts = PersistenceManager.shared.getPosts()
        } else {
            let filteredPosts = posts.filter { post in
                return post.title.lowercased().contains(searchText.lowercased())
            }
            self.posts = filteredPosts
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
