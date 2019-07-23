//
//  ActionBasedWithoutMilestonesViewController.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 4/13/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ActionBasedWithoutMilestonesViewController: BaseViewController {

    
    // This view controller will be used for action based, amount based and action&amount based challeneges
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var progressContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressContainerView: UIView!
    @IBOutlet weak var lockview: UIImageView!
    
    var challenge: Challenge?
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    @IBOutlet weak var actionProgressBarView: ProgressView!
    @IBOutlet weak var actionDescriptionLabel: UILabel!
    @IBOutlet weak var amountProgressView: ProgressView!
    @IBOutlet weak var amountDescriptionLabel: UILabel!
    @IBOutlet weak var challengeStatusDescriptionLabel: UILabel!
    @IBOutlet weak var challengeStatusImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }

    func setUp() {
        if let viewChallenge = self.challenge {
            self.challengeNameLabel.text = viewChallenge.gameName
            self.challengeDescriptionLabel.text = viewChallenge.description
            self.lockview.isHidden = viewChallenge.isUnlocked ?? false
            if lockview.isHidden {
                lockview.alpha = 0
                UIView.animate(withDuration: 1) {
                    self.lockview.alpha = 1.0
                }
            }
            
            setChallengeImage(from: viewChallenge)
            
            switch viewChallenge.status {
            case .locked:
                challengeStatusImageView.image = UIImage.image(named: "ChallengeLockedImage")
            case .inProgress:
                challengeStatusImageView.image = UIImage.image(named: "ChallengeInProgressImage")
            case .achieved:
                challengeStatusImageView.image = UIImage.image(named: "ChallengeAchievedImage")
            }
            
            challengeStatusImageView.alpha = 0
            UIView.animate(withDuration: 1.0) {
                self.challengeStatusImageView.alpha = 1.0
            }
            challengeStatusDescriptionLabel.text = viewChallenge.statusDescription
            let amount = viewChallenge.targetAmount ?? 0
            let label = LocalizationsKeys.GameballScreen.rankPointsName.rawValue.localized + String(amount) + "| "  + LocalizationsKeys.GameballScreen.pointsName.rawValue.localized + String(amount)
            pointsLabel.text = label
            
            if viewChallenge.status == .inProgress || viewChallenge.status == .achieved {
                
                
                switch viewChallenge.challengeType {
                case .ActionAndAmountBased:
                    // set progress bars & text
                    setActionAndAmountBasedData()
                    break
                case .ActionBased:
                    // set progress bars & text
                    // hide amount based sections
                    setActionBasedData()
                    break
                case .AmountBased:
                    // hide amount based sections
                    // use amount section action
                    setAmountBasedData()
                    break
                default:
                    break
                }
            }
            else {
                self.progressContainerViewHeightConstraint.constant = 0
                self.progressContainerView.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    func setActionAndAmountBasedData() {
        if let challenge = self.challenge {
            if challenge.actionsCompletedPercentage != nil {
                DispatchQueue.main.async {
                    self.actionProgressBarView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: Float((challenge.actionsCompletedPercentage ?? 0)/100.0))
                }
            }
            if challenge.amountCompletedPercentage != nil {
                DispatchQueue.main.async {
                    self.amountProgressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled:Float((challenge.amountCompletedPercentage ?? 0)/100.0))
                }
            }
        }
    }
    
    func setActionBasedData() {
        if let challenge = self.challenge {
            if challenge.actionsCompletedPercentage != nil {
                DispatchQueue.main.async {
                    self.actionProgressBarView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: Float((challenge.actionsCompletedPercentage ?? 0)/100.0))
                }
            }
            self.amountProgressView.isHidden = true
            self.amountDescriptionLabel.isHidden = true
            self.progressContainerViewHeightConstraint.constant = 220
        }
    }
    
    func setAmountBasedData() {
        if let challenge = self.challenge {
            if challenge.amountCompletedPercentage != nil {
                DispatchQueue.main.async {
                    self.actionProgressBarView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled:Float((challenge.amountCompletedPercentage ?? 0)/100.0))
                }
            }
            self.amountProgressView.isHidden = true
            self.amountDescriptionLabel.isHidden = true
            self.progressContainerViewHeightConstraint.constant = 220

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
    
    @IBAction func backbuttonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
