//
//  PostDetailsViewController.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit
import SwiftUI

class PostDetailsViewController: UIViewController {
    var stackView = UIStackView()
    let postView = PostView()
    var post: Post?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        actionOnBar(isHidden: false)
    }

    func setupUI() {
        guard let postId = post?.id else { return }
        
        // 1. Embed SwiftUI view in UIHostingController
        let commentsViewController: UIViewController = UIHostingController(rootView: CommentList(subreddit: "r/ios", postId: postId, onClick: { comment in
                let commentDetailsVC = UIHostingController(rootView: CommentDetails(comment: comment))
            self.navigationController?.pushViewController(commentDetailsVC, animated: true)
        }))

        // 2. Get reference to the HostingController view (UIView)
        let commentsView: UIView = commentsViewController.view
        
        stackView.addArrangedSubview(postView)
        stackView.addArrangedSubview(commentsView)
        
        stackView.axis = .vertical
        self.view.addSubview(stackView)
    
        self.view.backgroundColor = .secondarySystemBackground

        stackView.translatesAutoresizingMaskIntoConstraints = false
        postView.translatesAutoresizingMaskIntoConstraints = false
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postView.heightAnchor.constraint(equalToConstant: 300),
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])

        
        commentsViewController.didMove(toParent: self)
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
    
}

#Preview {
    return PostDetailsViewController()
}
