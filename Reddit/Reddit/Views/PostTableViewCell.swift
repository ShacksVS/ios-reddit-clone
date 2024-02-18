//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit	

class PostTableViewCell: UITableViewCell {
    private let postView = PostView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        postView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(post: Post) {
        postView.setupPost(postData: post)
    }
    
    private func setupUI() {
        addSubview(postView)
        postView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: topAnchor),
            postView.bottomAnchor.constraint(equalTo: bottomAnchor),
            postView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
