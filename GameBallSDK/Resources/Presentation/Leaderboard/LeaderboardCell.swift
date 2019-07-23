//
//  LeaderboardCell.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/16/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "award"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray103
        label.font = Fonts.appFont14
        return label
    }()
    
    private let playerLevelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appCustomDarkGray
        label.font = Fonts.appFont12Light
        return label
    }()
    
    private lazy var  playerInfoStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [playerNameLabel, playerLevelNameLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.spacing = 4.0
        return sv
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appGray225
        return view
    }()
    
    var profile: Profile? {
        didSet {
            guard let profile = profile else { return }
            setProperties(with: profile)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        addConstraints()
        
    }
    
    
    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(playerInfoStackView)
        contentView.addSubview(separatorView)
        //        contentView.addSubview(frubiesStackView)
    }
    
    private func addConstraints() {
        
        let height: CGFloat = 58
        let topSpacing: CGFloat = 17
        profileImageView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: height).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topSpacing).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topSpacing).isActive = true
        
        playerInfoStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 14).isActive = true
        playerInfoStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    private func setProperties(with profile: Profile) {
        
        let string1 = NSMutableAttributedString(string: "\(profile.level?.name ?? "Level") . Fr ", attributes: [
            NSAttributedString.Key.font: Fonts.appFont12Light,
            NSAttributedString.Key.foregroundColor: Colors.appCustomDarkGray
            ])
        
        let string2 = NSMutableAttributedString(string: "\(profile.accFrubies ?? 0)", attributes: [
            NSAttributedString.Key.font: Fonts.appFont12,
            NSAttributedString.Key.foregroundColor: Colors.appCustomDarkGray
            ])
        
        string1.append(string2)
        
        playerLevelNameLabel.attributedText = string1
        
        playerNameLabel.text = profile.name
        
        
        
        var path = profile.level?.icon?.fileName ?? "assets/images/bolt.png"
//        path = "/" + path
        
        NetworkManager.shared().loadImage(path: path) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.profileImageView.image = result
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
