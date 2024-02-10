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
        loadData()
    }

    func loadData() {
        Task{
            if let postData = await getPostData(limit: 1) {
                self.postView.textLabel.text = postData.title
                self.postView.usernameLabel.labelText.text = postData.author_fullname
                self.postView.ionLabel.labelText.text = postData.subreddit
                self.postView.domainLabel.labelText.text = postData.domain
                
                self.postView.upLabel.text = String(postData.ups! + postData.downs!)
                self.postView.commentLabel.text = String(postData.num_comments!)
                self.postView.saved = postData.saved!
                self.postView.postImage.kf.setImage(
                    with: URL(string: postData.thumbnail!),
                    placeholder: UIImage(named: "placeholder")
                )
            }
            else {
                print("Failed to load data")
            }
        }
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
}

#Preview {
    return ViewController()
}
