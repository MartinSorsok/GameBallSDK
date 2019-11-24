//
//  GB_ChallengeInMissionTableViewCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 10/19/19.
//

import UIKit

class GB_ChallengeInMissionTableViewCell: UITableViewCell {

    @IBOutlet weak var achievedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        numberOfAchievedLabel.isHidden = true
    }
    
    @IBOutlet weak var numberOfAchievedLabel: UILabel!{
        didSet{
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                numberOfAchievedLabel.font = Fonts.cairoRegularFont12
                
            } else {
                numberOfAchievedLabel.font = Fonts.montserratLightFont12
            }
        }
    }
    @IBOutlet weak var nextChallengeArrowImage: UIImageView!
    
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeTitleLabel: UILabel!{
        didSet{
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                challengeTitleLabel.font = Fonts.cairoRegularFont10
                
            } else {
                challengeTitleLabel.font = Fonts.montserratLightFont10
            }
        }
    }
    
    var challenge :Challenge? {
         didSet{
             challengeTitleLabel.text = challenge?.gameName
             setImage(withURL: challenge?.icon ?? "https://assets.gameball.co/sample/4.png" )
             if challenge?.achievedCount ?? 0 > 0 {
                 numberOfAchievedLabel.isHidden = false
                 numberOfAchievedLabel.text = "\(challenge?.achievedCount ?? 0)X"
                 achievedImage.image = UIImage(named: "CheckmarkNew.png")
             }
         }
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setImage(withURL: String) {
        let path = withURL
        NetworkManager.shared().loadImage(path: path.replacingOccurrences(of: " ", with: "%20")) { (myImage, error) in
            if let errorModel = error {
                 Helpers().dPrint(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.challengeImage.image = result
                    self.challengeImage.alpha = 0
                    UIView.animate(withDuration: 1.0, animations: {
                        self.challengeImage.alpha = 1.0
                    })
                }
            }
        }
    }
}
