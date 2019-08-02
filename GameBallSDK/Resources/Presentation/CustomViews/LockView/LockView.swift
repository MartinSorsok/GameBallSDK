//
//  LockView.swift
//  gameball_SDK
//
//  Created by Martin Sorsok on 2/16/19.
//  Copyright © 2019 Martin Sorsok. All rights reserved.
//

import UIKit

class LockView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appGray130
        return view
    }()
    
    private lazy var lockImageView: UIImageView = {
        
        let iv: UIImageView
        switch lockSize {
        case .small:
            iv = UIImageView(image: UIImage.image(named: "LockIcon"))
        case .large:
            iv = UIImageView(image: UIImage.image(named: "LockIconLarge"))
        }
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let lockSize: LockSize
    init(lockSize: LockSize) {
        self.lockSize = lockSize
        super.init(frame: .zero)
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        addSubview(containerView)
        containerView.addSubview(lockImageView)
    }
    
    private func addConstraints() {
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        lockImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        lockImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.height / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum LockSize {
    case small
    case large
}
