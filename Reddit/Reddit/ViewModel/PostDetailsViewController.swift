//
//  PostDetailsViewController.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit

class PostDetailsViewController: UIViewController, PostViewDelegate {
    let postView = PostView()

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
            postView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    // Buttons
    
    func configure(post: Post){
        postView.setupPost(postData: post)
        postView.delegate = self
    }
    
    func didTapShareButton(in postView: PostView) {
        if let postUrl = postView.urlString, let url = URL(string: postUrl) {
            let items = [url]

            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(ac, animated: true)
        } else {
            print("Post URL is not available. \(postView.urlString ?? "nil")")
        }
    }
}

#Preview {
    return ViewController()
}
