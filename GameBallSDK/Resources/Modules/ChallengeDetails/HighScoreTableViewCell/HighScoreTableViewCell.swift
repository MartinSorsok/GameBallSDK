//
//  HighScoreTableViewCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/31/19.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var highScoreLabel: UILabel!{
        didSet{
            highScoreLabel.text = GB_LocalizationsKeys.ChallengeDetails.highScore.rawValue.localized
            
            highScoreLabel.textColor = Colors.appMainColor
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                highScoreLabel.font = Fonts.cairoBoldFont16
                
            } else {
                highScoreLabel.font = Fonts.montserratSemiBoldFont16
            }
        }
    }
    
    @IBOutlet weak var yourScoreLabel: UILabel!{
        didSet{
            yourScoreLabel.text = GB_LocalizationsKeys.ChallengeDetails.yourHighScore.rawValue.localized
            
            yourScoreLabel.textColor = Colors.appBlack26
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                yourScoreLabel.font = Fonts.cairoRegularFont12
                
            } else {
                yourScoreLabel.font = Fonts.montserratLightFont12
            }
        }
    }
    
    @IBOutlet weak var highScoreValueLabel: UILabel!{
        didSet{
           // highScoreLabel.text = LocalizationsKeys.ChallengeDetails.yourHighScore.rawValue.localized
            
            highScoreValueLabel.textColor = Colors.appBlack26
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                highScoreValueLabel.font = Fonts.cairoBoldFont20
                
            } else {
                highScoreValueLabel.font = Fonts.montserratSemiBoldFont20
            }
        }
    }
    
    @IBOutlet weak var highScoreDescription: UILabel!{
        didSet{
             highScoreDescription.text = GB_LocalizationsKeys.ChallengeDetails.breakYourHighScore.rawValue.localized
            
            highScoreDescription.textColor = Colors.appGray170
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                highScoreDescription.font = Fonts.cairoBoldFont14
                
            } else {
                highScoreDescription.font = Fonts.montserratSemiBoldFont14
            }
        }
    }
    
    
    var challenge: Challenge?{
        didSet{
            highScoreValueLabel.text = "\(challenge?.highScoreAmount ?? 0)" + " " + (challenge?.amountUnit ?? "")
            

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
