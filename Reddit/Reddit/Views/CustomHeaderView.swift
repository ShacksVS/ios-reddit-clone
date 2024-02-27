////
////  CustomHeaderView.swift
////  Reddit
////
////  Created by Viktor Sovyak on 2/18/24.
////
//
//import UIKit
//
//class CustomHeaderView: UITableViewHeaderFooterView {    
//    private var saved = false
//    
//    weak var delegate: CustomHeaderViewDelegate?
//
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//
//        return label
//    }()
//    
//    private lazy var actionButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
//        button.tintColor = .systemYellow
//        button.addTarget(self, action: #selector(processFavoriteButton), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    @objc private func processFavoriteButton(_ sender: UIButton) {
//        saved.toggle()
//        let imageName = saved ? "bookmark.fill" : "bookmark"
//        sender.setImage(UIImage(systemName: imageName), for: .normal)
//        delegate?.didChangeSavedState(self, isSaved: saved)
//    }
//
//    
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(actionButton)
//        
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor, constant: -20),
//            titleLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
//            
//            actionButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
//            actionButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
//        ])
//    }
//    
//    func configure(title: String) {
//        titleLabel.text = title
//    }
//}
//
//
//protocol CustomHeaderViewDelegate: AnyObject {
//    func didChangeSavedState(_ headerView: CustomHeaderView, isSaved: Bool)
//}
