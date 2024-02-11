//
//  ViewController.swift
//  Sovyak02
//
//  Created by Viktor Sovyak on 2/8/24.
//

import UIKit

class ViewController: UIViewController {

    let postView = PostView()
    var data: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func loadData() {
        Task{
            if let postsData = await getPostData(subreddit: "ios", limit: 1, after: ""),
               let postData = postsData.first{
                self.postView.setupPost(postData: postData)
            }
            else {
                print("Failed to load data")
            }
        }
    }


    func setupUI() {
        loadData()
        self.view.addSubview(postView)
        self.view.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            postView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            postView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}

#Preview {
    return ViewController()
}
