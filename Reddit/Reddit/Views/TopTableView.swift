//
//  TopTableView.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/18/24.
//

import UIKit

class TopTableView: UIView {
    var domainLabel = UILabel()
    var favoriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        domainLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        domainLabel.font = UIFont(name: "Arial-BoldItalicMT", size: 13.0)
        
        self.addSubview(domainLabel)
        self.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            domainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            favoriteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
//    func configure(icon: String, text: String, color: UIColor = .secondaryLabel) {
//        self.icon.image = UIImage(systemName: icon)
//        self.labelText.text = text
//        self.icon.tintColor = color
//        self.labelText.textColor = color
//    }
}
