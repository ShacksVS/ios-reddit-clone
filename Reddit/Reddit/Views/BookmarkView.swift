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
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: -10))
        bezierPath.addLine(to: CGPoint(x: self.frame.width, y: -10))
        bezierPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        bezierPath.addLine(to: CGPoint(x: self.frame.width / 2, y: self.frame.height * 2 / 3))
        bezierPath.addLine(to: CGPoint(x: 0, y: self.frame.height))
        bezierPath.addLine(to: CGPoint(x: 0, y: -10))
        bezierPath.close()
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.strokeColor = UIColor.systemYellow.cgColor
        
        // Set up bookmark filling
        filled ? (shapeLayer.fillColor = UIColor.systemYellow.cgColor) : (shapeLayer.fillColor = UIColor.clear.cgColor)
        
        view.layer.addSublayer(shapeLayer)
        
//        self.isHidden = true
        self.alpha = 0
    }
    
    func animate() {
        // MARK: Appear animation
        DispatchQueue.main.async() { [weak self] in
            guard let self else { return }
            UIView.transition(
                with: self,
                duration: 0.35,
                options: .transitionCrossDissolve) {
//                    self.isHidden.toggle()
                    self.alpha = 1
                }
        }
        
        // MARK: Disappear animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            UIView.transition(
                with: self,
                duration: 0.35,
                options: .transitionCrossDissolve,
                animations: {
//                    self.isHidden.toggle()
                    self.alpha = 0
                },
                completion: { _ in
                    self.removeFromSuperview()
                })
        }
    }
}
