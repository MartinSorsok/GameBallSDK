//
//  StatusTableViewCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/31/19.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    
    @IBOutlet weak var statusLabel: UILabel!{
        didSet{
            statusLabel.text = LocalizationsKeys.ChallengeDetails.status.rawValue.localized

            statusLabel.textColor = Colors.appMainColor
            
            if Localizator.sharedInstance.language == Languages.arabic {
                statusLabel.font = Fonts.cairoBoldFont16
                
            } else {
                statusLabel.font = Fonts.montserratSemiBoldFont16
            }
        }
    }
    
    @IBOutlet weak var statusImage: UIImageView!
    
    @IBOutlet weak var ststusTitleLabel: UILabel!{
        didSet{
            ststusTitleLabel.textColor = Colors.appGray128
            
            if Localizator.sharedInstance.language == Languages.arabic {
                ststusTitleLabel.font = Fonts.cairoBoldFont20
                
            } else {
                ststusTitleLabel.font = Fonts.montserratSemiBoldFont20
            }
        }
    }
    
    @IBOutlet weak var numberOfTimesLabel: UILabel!{
        didSet{
            numberOfTimesLabel.textColor = Colors.appGray170
            
            if Localizator.sharedInstance.language == Languages.arabic {
                numberOfTimesLabel.font = Fonts.cairoRegularFont14
                
            } else {
                numberOfTimesLabel.font = Fonts.montserratLightFont14
            }
        }
    }
    
    
    var challenge: Challenge?{
        didSet {
            if challenge?.status == .inProgress {
                statusImage?.image = UIImage(named: "innerchallengeInProgress@2x.png")
                
            } else if challenge?.status == .achieved {
                statusImage?.image = UIImage(named: "innerchallengeAchieved@2x.png")
                numberOfTimesLabel.text = "\(challenge?.achievedCount ?? 0)" + " " + LocalizationsKeys.ChallengeDetails.times.rawValue.localized
                
            } else if challenge?.status == .locked  {
                statusLabel.isHidden = true
                numberOfTimesLabel.text = LocalizationsKeys.ChallengeDetails.YouNeed.rawValue.localized + " " + "\(challenge?.levelName ?? "")" + " " + LocalizationsKeys.ChallengeDetails.toUnlock.rawValue.localized
                statusImage?.image = UIImage(named: "innerchallengeLocked@2x.png")
            }
            
            statusImage.alpha = 0
            UIView.animate(withDuration: 1.0) {
                self.statusImage.alpha = 1.0
            }
            ststusTitleLabel.text =  challenge?.statusDescription

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

enum Status {
    case Locked
    case Achieved
    case Progress
}
