//
//  ChallengeDetailsHeaderCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/31/19.
//

import UIKit

class ChallengeDetailsHeaderCell: UITableViewCell {

    @IBOutlet weak var containerCellMainView: UIView!{
        didSet{
            containerCellMainView.backgroundColor = Colors.appGray242

        }
    }
    
    @IBOutlet weak var giftImageScore: UIImageView!
    @IBOutlet weak var challengeImage: UIImageView!{
        didSet {
//            challengeImage.layer.cornerRadius = challengeImage.layer.bounds.height / 2
//            challengeImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var challengeName: UILabel!{
        didSet{
            challengeName.textColor = Colors.appBlack26
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                challengeName.font = Fonts.cairoBoldFont20
                
            } else {
                challengeName.font = Fonts.montserratSemiBoldFont20
            }
        }
    }
    
    @IBOutlet weak var challengeDescription: UILabel!{
        didSet{
            challengeDescription.textColor = Colors.appBlack26
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                challengeDescription.font = Fonts.cairoRegularFont14
                
            } else {
                challengeDescription.font = Fonts.montserratLightFont14
            }
        }
    }
    
    @IBOutlet weak var challengeScore: UILabel!{
        didSet{
            challengeScore.textColor = Colors.appBlack26

            if GB_Localizator.sharedInstance.language == Languages.arabic {
                challengeScore.font = Fonts.cairoBoldFont12
                
            } else {
                challengeScore.font = Fonts.montserratSemiBoldFont10
            }
        }
    }
   
    var challenge: Challenge?{
        didSet{
            
            challengeName.text = challenge?.gameName
            challengeDescription.text = challenge?.description
            setImage(withURL: challenge?.icon ?? "https://assets.gameball.co/sample/4.png" )
          
            
            if challenge?.rewardPoints == 0 && challenge?.rewardFrubies == 0  {
                challengeScore.text = ""
                giftImageScore.isHidden = true
                
            } else if challenge?.rewardPoints == 0 {
                challengeScore.text = "\(challenge?.rewardFrubies ?? 0) \(GameballApp.clientBotStyle?.rankPointsName ?? "")"
            }  else if challenge?.rewardFrubies == 0 {
                challengeScore.text = "\(challenge?.rewardPoints ?? 0) \(GameballApp.clientBotStyle?.walletPointsName ?? "")"
            }  else {
                challengeScore.text = "\(challenge?.rewardFrubies ?? 0) \(GameballApp.clientBotStyle?.rankPointsName ?? "") | \(challenge?.rewardPoints ?? 0) \(GameballApp.clientBotStyle?.walletPointsName ?? "")"
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
