//
//  AchivementHighscoreViewController.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 4/13/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class AchivementHighscoreViewController: UIViewController {

    
    @IBOutlet weak var lockview: UIImageView!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var challengeDescriptionLabel: UILabel!

    var challenge: Challenge?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
            self.highscoreLabel.text = viewChallenge.highScoreAmount ?? "No Amount"
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
