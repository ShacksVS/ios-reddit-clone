//
//  PostView.swift
//  Sovyak02
//
//  Created by Viktor Sovyak on 2/8/24.
//

import UIKit
import Kingfisher

class PostView: UIView {
    let usernameLabel = LabelView()
    let ionLabel = LabelView()
    let domainLabel = LabelView()
    let commentLabel = UILabel()
    var postImage = UIImageView()
    let textLabel = UILabel()
    var upLabel = UILabel()
    var saved: Bool = false
    
    private lazy var upButton = createButton(systemName: "arrowshape.up.circle.fill", action: #selector(processUPButton))
    private lazy var commentButton = createButton(systemName: "bubble.right.fill", action: #selector(processCommentButton))
    private lazy var favoriteButton = createButton(systemName: "bookmark", action: #selector(processFavoriteButton), color: .systemYellow)
    private lazy var shareButton = createButton(systemName: "square.and.arrow.up", action: #selector(processShareButton))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPost(postData: Post) {
        textLabel.text = postData.title
        usernameLabel.labelText.text = postData.authorFullname
        ionLabel.labelText.text = postData.subreddit
        domainLabel.labelText.text = postData.domain

        let upVotes = postData.ups ?? 0
        let downVotes = postData.downs ?? 0
        upLabel.text = "\(upVotes + downVotes)"
        commentLabel.text = "\(postData.numComments ?? 0)"
        saved = postData.saved ?? false
        
        if let thumbnailUrl = postData.thumbnail, let url = URL(string: thumbnailUrl) {
            postImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            postImage.image = UIImage(resource: .example)
        }
    }
    
    func setupView() {
        usernameLabel.configure(icon: "person.circle", text: "username")
        ionLabel.configure(icon: "record.circle", text: "ion")
        domainLabel.configure(icon: "record.circle", text: "domain")
        textLabel.textColor = .label
        textLabel.numberOfLines = 4
        
        upLabel.textColor = .systemBlue
        commentLabel.textColor = .systemBlue
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        upLabel.translatesAutoresizingMaskIntoConstraints = false
        
        postImage.contentMode = .scaleAspectFit
        
        
        self.addSubview(usernameLabel)
        self.addSubview(ionLabel)
        self.addSubview(domainLabel)
        self.addSubview(upButton)
        self.addSubview(commentLabel)
        self.addSubview(shareButton)
        self.addSubview(postImage)
        self.addSubview(textLabel)
        self.addSubview(favoriteButton)
        self.addSubview(upLabel)
        self.addSubview(commentButton)
        
//        guard
//            let width = postImage.image?.cgImage?.width,
//            let height = postImage.image?.cgImage?.height
//        else { return }
//        let aspectRatio = Double(width / height)
        
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            ionLabel.leadingAnchor.constraint(equalTo: usernameLabel.labelText.trailingAnchor, constant: 10),
//            ionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            domainLabel.leadingAnchor.constraint(equalTo: ionLabel.labelText.trailingAnchor, constant: 10),
//            domainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            domainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textLabel.topAnchor.constraint(equalTo: usernameLabel.topAnchor, constant: 35),
            textLabel.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -8),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            postImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            postImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            postImage.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            postImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42),
//            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: CGFloat(1.0 / aspectRatio)),
            
            upButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            upButton.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            
            upLabel.leadingAnchor.constraint(equalTo: upButton.trailingAnchor, constant: 3),
            upLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            
            commentButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: -20),
            commentButton.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            
            commentLabel.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 3),
            commentLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            shareButton.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 4),
            
            self.heightAnchor.constraint(lessThanOrEqualToConstant: 350)
        ])
    }
    
    private func createButton(systemName: String, action: Selector, color: UIColor = .systemBlue) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = color
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
     }
    
    @objc private func processFavoriteButton(_ sender: UIButton) {
        saved.toggle()
        let imageName = saved ? "bookmark.fill" : "bookmark"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    
    }
    
    @objc private func processUPButton() {
        print("Clicked on UpButton")
    }
    
    @objc private func processCommentButton() {
        print("Clicked on CommentButton")
    }
    @objc private func processShareButton() {
        print("Clicked on ShareButton")
    }
}

