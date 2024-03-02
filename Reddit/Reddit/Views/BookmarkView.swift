//
//  BookmarkView.swift
//  Reddit
//
//  Created by Viktor Sovyak on 3/2/24.
//

import UIKit

class BookmarkView: UIView {
    var filled: Bool = Bool() {
        didSet {
            self.drawBookmark(in: self)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawBookmark(in: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpFilling(filled: Bool){
        self.filled = filled
        
    }
    
    func drawBookmark(in view : UIView) {
//        path.move(to: CGPoint(x: view.frame.width / 2, y: view.frame.height / 2))
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 100, y: 0))
        bezierPath.addLine(to: CGPoint(x: 100, y: 100))
        bezierPath.addLine(to: CGPoint(x: 50, y: 50))
        bezierPath.addLine(to: CGPoint(x: 0, y: 100))
        bezierPath.addLine(to: .zero)
        bezierPath.close()
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.strokeColor = UIColor.systemYellow.cgColor
        
        if filled {
            shapeLayer.fillColor = UIColor.systemYellow.cgColor
        } else {
            shapeLayer.fillColor = UIColor.clear.cgColor

        }
        
        view.layer.addSublayer(shapeLayer)
    }
}
