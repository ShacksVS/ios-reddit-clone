//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit	

class PostTableViewCell: UITableViewCell, PostViewDelegate {
    
    private let postView = PostView()
    
    weak var delegate: PostTableViewCellDelegate?
    
    func didTapShareButton(in postView: PostView) {
        if let postUrl = postView.urlString, let url = URL(string: postUrl) {
            delegate?.didTapShareButton(self, url: url)
        } else {
            print("Post URL is not available. \(postView.urlString ?? "nil")")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        postView.isUserInteractionEnabled = true
//        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(post: Post) {
        postView.setupPost(postData: post)
        postView.delegate = self
    }
    
    private func setupUI() {
        contentView.addSubview(postView)
        
        postView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

protocol PostTableViewCellDelegate: AnyObject {
    func didTapShareButton(_ cell: PostTableViewCell, url: URL)
}
