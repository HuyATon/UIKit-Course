//
//  File.swift
//  Bankey
//
//  Created by Huy Ton Anh on 05/12/2024.
//

import UIKit

class ShakeyBellView: UIView {
    
    let imageView = UIImageView()
    let buttonBadge = UIButton()
    
    let buttonHeight: CGFloat = 16
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 24, height: 24)
    }
}

extension ShakeyBellView {
    
    private func style() {
        
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        buttonBadge.translatesAutoresizingMaskIntoConstraints = false
        buttonBadge.backgroundColor = .systemRed
        buttonBadge.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        buttonBadge.layer.cornerRadius = buttonHeight / 2
        buttonBadge.setTitleColor(.white, for: .normal)
        buttonBadge.setTitle("5", for: .normal)
    }
    
    private func layout() {
        
        addSubview(self.imageView)
        addSubview(self.buttonBadge)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            buttonBadge.topAnchor.constraint(equalTo: imageView.topAnchor),
            buttonBadge.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -9),
            buttonBadge.heightAnchor.constraint(equalToConstant: 16),
            buttonBadge.widthAnchor.constraint(equalToConstant: 16)
            
        ])
    }
    
    private func setup() {
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }
}

extension ShakeyBellView {
    
    @objc func imageViewTapped() {
        shakeWith(duration: 1, angle: .pi/8, yOffset: 0.0)
    }
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        
        let frames = 6
        let frameDuration = Double(duration / Double(frames))
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0) {
            
            for i in 0...frames {
                let isEven = i % 2 == 0
                let currentAngle: CGFloat = isEven ? -angle : angle
                
                let affineTransform = (i == frames) ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: currentAngle)
                
                UIView.addKeyframe(withRelativeStartTime: Double(i) * frameDuration, relativeDuration: frameDuration) {
                    self.imageView.transform = affineTransform
                }
            }
        }
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
