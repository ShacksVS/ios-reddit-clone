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
    
    private let upButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.up.circle.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(nil, action: #selector(processUPButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.right.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(nil, action: #selector(processCommentButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(nil, action: #selector(processFavoriteButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(nil, action: #selector(processShareButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
//        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
//        ionLabel.translatesAutoresizingMaskIntoConstraints = false
//        domainLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        upLabel.translatesAutoresizingMaskIntoConstraints = false
        
        postImage.image = UIImage(resource: .example)   // just a placeholder for not loaded image
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
            postImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -38),
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
}

