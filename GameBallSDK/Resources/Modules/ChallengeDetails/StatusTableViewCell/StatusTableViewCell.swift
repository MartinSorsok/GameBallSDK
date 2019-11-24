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
            statusLabel.text = GB_LocalizationsKeys.ChallengeDetails.status.rawValue.localized

            statusLabel.textColor = Colors.appMainColor
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
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
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                ststusTitleLabel.font = Fonts.cairoBoldFont20
                
            } else {
                ststusTitleLabel.font = Fonts.montserratSemiBoldFont20
            }
        }
    }
    
    @IBOutlet weak var numberOfTimesLabel: UILabel!{
        didSet{
            numberOfTimesLabel.textColor = Colors.appGray170
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
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
                numberOfTimesLabel.text = ""
                if challenge?.challengeType == .Birthday || challenge?.challengeType == .Anniversary {
                    ststusTitleLabel.text =  challenge?.description
                }else {
                    ststusTitleLabel.text =  challenge?.statusDescription
                }
                
                guard let highScore = challenge?.highScore else {return}
                
                numberOfTimesLabel.text = "\(GB_LocalizationsKeys.ChallengeDetails.exceedMaximum.rawValue.localized) \(highScore) \(challenge?.amountUnit ?? "")"
                
            } else if challenge?.status == .achieved {
                statusImage?.image = UIImage(named: "innerchallengeAchieved@2x.png")
                numberOfTimesLabel.text = "\(challenge?.achievedCount ?? 0)" + " " + GB_LocalizationsKeys.ChallengeDetails.times.rawValue.localized
                ststusTitleLabel.text =  challenge?.statusDescription

                
            } else if challenge?.status == .locked  {
                statusLabel.isHidden = true
                numberOfTimesLabel.text = GB_LocalizationsKeys.ChallengeDetails.YouNeed.rawValue.localized + " " + "\(challenge?.levelName ?? "")" + " " + GB_LocalizationsKeys.ChallengeDetails.toUnlock.rawValue.localized
                statusImage?.image = UIImage(named: "innerchallengeLocked@2x.png")
                ststusTitleLabel.text =  challenge?.statusDescription

            }
            
            statusImage.alpha = 0
            UIView.animate(withDuration: 1.0) {
                self.statusImage.alpha = 1.0
            }

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
