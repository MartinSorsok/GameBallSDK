//
//  DropdownView.swift
//  GameBallDemo
//
//  Created by Omar Ali on 2/2/19.
//  Copyright © 2019 Omar Ali. All rights reserved.
//

import UIKit

protocol DropdownViewDelegate {
    func dropdownView(_ dropdownView: DropdownView, didSelectItemAt index: Int, for string: String)
}

class DropdownView: UIView {
    
    var delegate: DropdownViewDelegate?
    
    private let choiceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appCustomDarkGray
        label.font = Fonts.appFont12
        label.text = "ALL ACHIEVEMENTS"
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let iv  = UIImageView(image: UIImage(named: "award"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var titleStackView: UIStackView  = {
        let sv = UIStackView(arrangedSubviews: [choiceLabel, arrowImageView])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        return sv
    }()
    
    private let choicesStackViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appGray204
        view.clipsToBounds = true
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    private let choicesStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 10
        return sv
    }()
    
    var choices: [String] = [] {
        didSet {
            setupChoices(choices)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnView)))
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(titleStackView)
//        addSubview(choicesStackViewContainer)
        choicesStackViewContainer.addSubview(choicesStackView)
    }
    
    override func didMoveToSuperview() {
        guard let superView = superview else { return }
        superView.addSubview(choicesStackViewContainer)
        
        choicesStackViewContainer.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor).isActive = true
        choicesStackViewContainer.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor).isActive = true
        choicesStackViewContainer.topAnchor.constraint(equalTo: titleStackView.bottomAnchor).isActive = true
        choicesHeightConstraint = choicesStackViewContainer.heightAnchor.constraint(equalToConstant: 0)
        choicesHeightConstraint?.isActive = true
        
        choicesStackView.topAnchor.constraint(equalTo: choicesStackViewContainer.topAnchor, constant: 10).isActive = true
        choicesStackView.bottomAnchor.constraint(equalTo: choicesStackViewContainer.bottomAnchor, constant: -10).isActive = true
        choicesStackView.leadingAnchor.constraint(equalTo: choicesStackViewContainer.leadingAnchor).isActive = true
        choicesStackView.trailingAnchor.constraint(equalTo: choicesStackViewContainer.trailingAnchor).isActive = true
        
    }
    
    private var choicesHeightConstraint: NSLayoutConstraint!
    private func addConstraints() {
        titleStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupChoices(_ choices: [String]) {
        choices.forEach({
            [weak self] choice in
            let label = UILabel()
            label.text = choice
            label.textAlignment = .center
            label.textColor = Colors.appCustomDarkGray
            label.font = Fonts.appFont12
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectItem(sender:))))
            self?.choicesStackView.addArrangedSubview(label)
        })
    }
    
    
    private func showChoices() {
        UIView.animate(withDuration: 0.2, animations: {
            self.choicesHeightConstraint.constant = 70
            self.superview?.layoutIfNeeded()
        })
    }
    
    private func hideChoices() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.choicesHeightConstraint.constant = 0
            self.superview?.layoutIfNeeded()
        })
    }
    
    private var choicesShown: Bool {
        return choicesHeightConstraint?.constant != 0
    }
    @objc private func didTapOnView() {
        if choicesShown {
            hideChoices()
        }
        else {
            showChoices()
            
        }
    }
    
    @objc private func didSelectItem(sender: UITapGestureRecognizer) {
        
        let labels = choicesStackView.arrangedSubviews
        if let selectedIndex = labels.lastIndex(where: {$0 == sender.view}), let text = (sender.view as? UILabel)?.text {
            delegate?.dropdownView(self, didSelectItemAt: selectedIndex, for: text)
        }
        
        hideChoices()
        
    }
}

