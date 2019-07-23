//
//  LeaderboardHEaderView.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/16/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class LeaderboardHeaderView: UIView {
    
    static var height: CGFloat {
        return 80
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appOrange
        label.font = Fonts.appFont20Bold
        label.text =  LocalizationsKeys.LeaderBoardScreen.leaderboardTitle.rawValue.localized
        return label
    }()
    
    private let playerRankingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = Colors.appCustomDarkGray
        label.font = Fonts.appFont12Light
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appGray225
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        addubviews()
        addConstraints()
    }
    
    private func addubviews() {
        addSubview(titleLabel)
        addSubview(playerRankingLabel)
        addSubview(separatorView)
    }
    
    private func addConstraints() {
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        
        playerRankingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        playerRankingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        playerRankingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    func setProperties() {
        playerRankingLabel.text = "Your rank in the leaderboard is 182"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
