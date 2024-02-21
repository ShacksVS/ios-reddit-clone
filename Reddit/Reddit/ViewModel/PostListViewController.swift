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
    
    struct Const {
        static let cellIdentifier = "PostTableViewCell"
        static let headerIdentifier = "CustomHeaderView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadPosts()
        self.actionOnBar(isHidden: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.actionOnBar(isHidden: true)
        print(posts.count)
    }
    
    private func setupTableView() {
        view.backgroundColor = UIColor.systemBackground

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: Const.cellIdentifier)
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: Const.headerIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
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

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        cell.configure(post: post)
        
        cell.delegate = self
        
        return cell
    }
}

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.headerIdentifier) as! CustomHeaderView
        headerView.configure(title: subreddit)
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.indexPathsForVisibleRows?
            .contains(where: { $0.row == self.posts.count - 3 }) == true
            && !isLoadingPosts
            && !allFound {
            isLoadingPosts = true
            loadPosts(after: lastPost)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostDetailsViewController()
        vc.configure(post: posts[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25 // Adjust the height as needed
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
}
extension PostListViewController: PostTableViewCellDelegate {
    func didTapShareButton(_ cell: PostTableViewCell, url: URL) {
        print("calculationg")
        let items = [url]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}
