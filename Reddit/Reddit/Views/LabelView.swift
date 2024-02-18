//
//  LabelView.swift
//  Sovyak02
//
//  Created by Viktor Sovyak on 2/8/24.
//

import UIKit

class LabelView: UIView {
    let icon = UIImageView()
    var labelText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = UIFont(name: "Arial-BoldItalicMT", size: 13.0)
        
        self.addSubview(icon)
        self.addSubview(labelText)
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            labelText.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 4),
            icon.centerYAnchor.constraint(equalTo: labelText.centerYAnchor),
            
        ])
    }
    
    func configure(icon: String, text: String, color: UIColor = .secondaryLabel) {
        self.icon.image = UIImage(systemName: icon)
        self.labelText.text = text
        self.icon.tintColor = color
        self.labelText.textColor = color
    }
}
