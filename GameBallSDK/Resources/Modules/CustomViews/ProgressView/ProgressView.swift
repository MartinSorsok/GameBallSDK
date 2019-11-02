//
//  ProgressView.swift
//  GameBallDemo
//
//  Created by Omar Ali on 2/1/19.
//  Copyright © 2019 Omar Ali. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    var properties: ProgressViewProperties? {
        didSet {
            if let properties = properties {
                setupProperties(properties)
            }
        }
    }
    
    private let filledView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = frame.height / 2
        filledView.layer.cornerRadius = frame.height / 2
        
    }
    
    private func setupProperties(_ properties: ProgressViewProperties) {
        backgroundColor = properties.backgroundColor
        filledView.backgroundColor = properties.filledColor
        addFilledView(with: properties.percentageFilled)
        // ToDo: apply bot settings here 
    }
    
    private var filledViewWidthConstraint: NSLayoutConstraint?
    private func addFilledView(with percentage: Float) {
         Helpers().dPrint(percentage)
        addSubview(filledView)
        
        filledView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        filledView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        filledView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        filledViewWidthConstraint = filledView.widthAnchor.constraint(equalToConstant: 0)
        filledViewWidthConstraint?.isActive = true
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
                [weak self] in
                self?.filledViewWidthConstraint?.constant = (self?.frame.width ?? 0) * CGFloat(percentage)
                self?.layoutIfNeeded()
                }, completion: nil)
        })
        
    }
    
}

struct ProgressViewProperties {
    
    init(backgroundColor: UIColor, filledColor: UIColor, percentageFilled: Float) {
        
        self.backgroundColor = backgroundColor
        self.filledColor = filledColor
        self.percentageFilled = percentageFilled < 1.1 ? percentageFilled : 0
    }
    
    let backgroundColor: UIColor
    let filledColor: UIColor
    let percentageFilled: Float
}
