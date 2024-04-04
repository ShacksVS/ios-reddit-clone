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
    var postImage = UIImageView()
    let textLabel = UILabel()
    var isSaved: Bool = false
    var urlString: String?
    var post: Post?
    
    weak var delegate: PostViewDelegate?

    
    private lazy var upButton = createButton(systemName: "arrowshape.up.circle.fill", action: #selector(processUPButton))
    private lazy var commentButton = createButton(systemName: "bubble.right.fill", action: #selector(processCommentButton))
    
    private lazy var favoriteButton: UIButton = {
        let imageName = isSaved ? "bookmark.fill" : "bookmark"
        let button = createButton(systemName: imageName, action: #selector(processFavoriteButton), color: .systemYellow)
        return button
    }()
    
    private lazy var shareButton = createButton(systemName: "square.and.arrow.up", action: #selector(processShareButton))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPost(postData: Post) {
        self.post = postData
        
        self.isSaved = PersistenceManager.shared.getPosts().contains(where: { self.post?.name == $0.name })
        
        urlString = postData.postURL.absoluteString
        
        textLabel.text = postData.title

        usernameLabel.labelText.text = postData.authorFullname
        domainLabel.labelText.text = postData.domain
    
        let upVotes = postData.ups
        let downVotes = postData.downs
        
        let timestamp = postData.createdUtc
        let postDate = Date(timeIntervalSince1970: timestamp)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let dateStr = formatter.localizedString(for: postDate, relativeTo: Date())

        ionLabel.labelText.text = "\(dateStr)"
        
        self.upButton.setTitle(" \(upVotes + downVotes)", for: .normal)
        self.commentButton.setTitle(" \(postData.numComments)", for: .normal)
        updateFavoriteButtonAppearance()
        
        if postData.url?.hasSuffix(".jpeg") == false {
            postImage.image = UIImage(resource: .example)
            return
        }
//        print(postData.thumbnail ?? "nil")
        
        if let thumbnailUrl = postData.url, let url = URL(string: thumbnailUrl) {
            postImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }
    
    private func updateFavoriteButtonAppearance() {
        let imageName = isSaved ? "bookmark.fill" : "bookmark"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func setupView() {
        usernameLabel.configure(icon: "person.circle", text: "username")
        ionLabel.configure(icon: "record.circle", text: "ion")
        domainLabel.configure(icon: "record.circle", text: "domain")
        textLabel.textColor = .label
        textLabel.numberOfLines = 4
        postImage.image = UIImage(resource: .example)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        
        // toDo gesture Recognizer
        postImage.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(processFavoriteGesture))
        recognizer.numberOfTapsRequired = 2
        postImage.addGestureRecognizer(recognizer)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        postImage.contentMode = .scaleAspectFit

        
        self.addSubview(usernameLabel)
        self.addSubview(ionLabel)
        self.addSubview(domainLabel)
        self.addSubview(upButton)
        self.addSubview(shareButton)
        self.addSubview(postImage)
        self.addSubview(textLabel)
        self.addSubview(favoriteButton)
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
//            textLabel.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -15),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            postImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            postImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            postImage.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 12),
            postImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: 0.5),
            
            upButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            upButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -35),
            
            commentButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: -20),
            commentButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -35),
        
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            shareButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -37),
            
            self.heightAnchor.constraint(lessThanOrEqualToConstant: 400)
        ])
    }
    
    private func createButton(systemName: String, action: Selector, color: UIColor = .systemBlue) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = color
        button.setTitleColor(.systemBlue, for: .normal)
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, 100, 100)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.configuration?.imagePadding = 20
        // toDo
//        https://www.kodeco.com/27854768-uibutton-configuration-tutorial-getting-started
        
        return button
     }
    
    @objc private func processFavoriteButton(_ sender: UIButton) {
        guard let post else { return }
        self.isSaved.toggle()
        updateFavoriteButtonAppearance()
        
        PersistenceManager.shared.togglePostSave(post)
        
        let bookmarkView = BookmarkView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        bookmarkView.setUpFilling(filled: isSaved)
        bookmarkView.center = postImage.center
        self.addSubview(bookmarkView)
        bookmarkView.animate()
    }
    
    @objc private func processFavoriteGesture(_ recognizer: UITapGestureRecognizer) {
        processFavoriteButton(favoriteButton)
    }

    
    @objc private func processUPButton() {
//        delegate?.didTapUpButton(in: self)
        print("Pressed Up")
    }
    
    @objc private func processCommentButton() {
        guard let post else { return }

        delegate?.didTapCommentButton(for: post)
    }
    
    @objc private func processShareButton() {
        guard let post else { return }
        
        delegate?.didTapShareButton(for: post)
    }
    
}
