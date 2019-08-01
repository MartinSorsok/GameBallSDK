//
//  ActionBasedViewController.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 4/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ActionBasedViewController: UIViewController {

    
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var milestonesTableView: UITableView!
    @IBOutlet weak var milestonesTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var achievmentImageView: UIImageView!
    @IBOutlet weak var achievementImageLabel: UILabel!
    
    let cellReuseIdentifier = "MilestoneTableViewCell"
    var challenge: Challenge?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.milestonesTableView.delegate = self
        self.milestonesTableView.dataSource = self
        self.milestonesTableView.register(UINib(nibName: "MilestoneTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.milestonesTableView.separatorInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 4)
        self.milestonesTableView.reloadData()
    }

    
    public init() {
        super.init(nibName: "ActionBasedViewController", bundle: Bundle.init(for: type(of: self)))
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUp() {
        if let viewChallenge = self.challenge {
            self.challengeNameLabel.text = viewChallenge.gameName
            self.challengeDescriptionLabel.text = viewChallenge.description
            self.lockImageView.isHidden = viewChallenge.isUnlocked ?? false
            if lockImageView.isHidden {
                lockImageView.alpha = 0
                UIView.animate(withDuration: 1) {
                    self.lockImageView.alpha = 1.0
                }
            }
            
            setChallengeImage(from: viewChallenge)
            
            switch viewChallenge.status {
            case .locked:
                achievmentImageView.image = UIImage.image(named: "ChallengeLockedImage")
            case .inProgress:
                achievmentImageView.image = UIImage.image(named: "ChallengeInProgressImage")
            case .achieved:
                achievmentImageView.image = UIImage.image(named: "ChallengeAchievedImage")
            }
            
            achievmentImageView.alpha = 0
            UIView.animate(withDuration: 1.0) {
                self.achievmentImageView.alpha = 1.0
            }
            achievementImageLabel.text = viewChallenge.statusDescription
            let amount = viewChallenge.targetAmount ?? 0
            let label = String(amount) + " frubies | " + String(amount) + " points"
            pointsLabel.text = label
            
        }
        
    }
    
    func setChallengeImage(from model: Challenge) {
        let path = model.icon ?? "assets/images/bolt.png"
        NetworkManager.shared().loadImage(path: path) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                
                DispatchQueue.main.async {
                    self.challengeImageView.image = result
                    self.challengeImageView.alpha = 0
                    UIView.animate(withDuration: 1.0, animations: {
                        self.challengeImageView.alpha = 1.0
                    })
                }
            }
        }
    }



}

extension ActionBasedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MilestoneTableViewCell
//        if let milestone = self.challenge?.milestones?[indexPath.row] {
//            cell.setData(milestone: milestone)
//        }
        // set cell data
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.milestonesTableViewHeightConstraint?.constant = self.milestonesTableView.contentSize.height
    }
    
    
}
