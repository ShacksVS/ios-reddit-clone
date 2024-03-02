//
//  PostDetailsViewController.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit

class PostDetailsViewController: UIViewController {
    let postView = PostView()
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        actionOnBar(isHidden: false)
    }

    func setupUI() {
        self.view.addSubview(postView)
        self.view.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            postView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            postView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            postView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
        
    func configure(post: Post){
        print(post)
        self.post = post
        postView.setupPost(postData: post)
        postView.delegate = self
    }
    
}

// MARK: PostViewDelegate
extension PostDetailsViewController: PostViewDelegate {
    func didTapCommentButton(for post: Post) {
        print("Tabbed on comment")
    }
    
    
    func didTapShareButton(for post: Post) {
        let ac = UIActivityViewController(activityItems: [post.postURL], applicationActivities: nil)
        present(ac, animated: true)
    }
    
//    func didTapFavoriteButton(for post: Post) {
//        PersistenceManager.shared.togglePostSave(post)
//    }
}

#Preview {
    return ViewController()
}
