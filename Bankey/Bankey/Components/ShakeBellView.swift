//
//  ShakeBellView.swift
//  Bankey
//
//  Created by 구자윤 on 2022/10/04.
//

import UIKit

class ShakeBellView: UIView {
    let imageView = UIImageView()
    let imageSize: CGFloat = 24
    let notiButton = UIButton()
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
        return CGSize(width: 48, height: 48)
    }
}

// MARK: Action
extension ShakeBellView {
    @objc func tappedShakeBell() {
        shakeBell(duration: 1, angle: .pi / 8, yOffset: 0.0)
    }
    private func shakeBell(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration = Double(1 / numberOfFrames)
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 2, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 3, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 4, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 5, relativeDuration: frameDuration) {
                self.imageView.transform = .identity
            }
        }
    }
}

// MARK: Style
extension ShakeBellView {
    func setup() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tappedShakeBell))
        
        imageView.addGestureRecognizer(recognizer)
        imageView.isUserInteractionEnabled = true
    }
    
    func style() {
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        // notiButton
        notiButton.translatesAutoresizingMaskIntoConstraints = false
        notiButton.backgroundColor = .systemRed
        notiButton.setTitle("9", for: .normal)
        notiButton.layer.cornerRadius = buttonHeight / 2
        notiButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        notiButton.titleLabel?.tintColor = .white
    }
    
    func layout() {
        addSubViews([imageView, notiButton])
        
        // imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
        ])

        // notiButton
        NSLayoutConstraint.activate([
            notiButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            notiButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            notiButton.widthAnchor.constraint(equalToConstant: buttonHeight),
            notiButton.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])

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
