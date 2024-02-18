//
//  PostDetailsViewController.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit

class PostDetailsViewController: UIViewController {

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
            postView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    func configure(post: Post){
        self.postView.setupPost(postData: post)
    }
}

#Preview {
    return ViewController()
}
