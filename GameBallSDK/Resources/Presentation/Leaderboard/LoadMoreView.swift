//
//  LoadMoreView.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/16/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit


class LoadMoreView: UIView {
    
    static var height: CGFloat {
        return 30
    }
    
    var buttonPressedAction: (() -> Void)?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load More", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(actionOfButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        addubviews()
        addConstraints()
    }
    
    
    
    private func addubviews() {
        addSubview(button)
    }
    
    private func addConstraints() {
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    @objc private func actionOfButton() {
        buttonPressedAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
