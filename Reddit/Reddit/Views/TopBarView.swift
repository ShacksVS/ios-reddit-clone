//
//  TopBarView.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/24/24.
//

import UIKit

class TopBarView: UIView {
    
    let titleLabel = UILabel()
    let actionButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = UIColor.secondarySystemBackground
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        
        actionButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        actionButton.tintColor = .systemYellow
        self.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            actionButton.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10),
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
