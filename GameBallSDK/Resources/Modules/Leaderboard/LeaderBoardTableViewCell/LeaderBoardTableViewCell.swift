//
//  LeaderBoardTableViewCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/27/19.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var numbersView: UIView!{
        didSet{
            
            numbersView.layer.cornerRadius = numbersView.frame.size.width/2
            numbersView.clipsToBounds = true
            numbersView.backgroundColor = Colors.appGray128
        }
    }
    
    @IBOutlet weak var rankingNumberLabel: UILabel!{
        didSet {
            // rankingNumberLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                rankingNumberLabel.font = Fonts.cairoBoldFont8
                
            } else {
                rankingNumberLabel.font = Fonts.montserratSemiBoldFont8
            }
            rankingNumberLabel.textColor = .white
                //UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
        }
    }
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!{
        didSet {
            // rankingNumberLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                playerName.font = Fonts.cairoRegularFont12
                
            } else {
                playerName.font = Fonts.montserratLightFont12
            }
//            rankingNumberLabel.textColor = .white
            //UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
        }
    }
    
    @IBOutlet weak var playerRank: UILabel!{
        didSet {
            // rankingNumberLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                playerRank.font = Fonts.cairoBoldFont12
                
            } else {
                playerRank.font = Fonts.montserratSemiBoldFont12
            }
//            rankingNumberLabel.textColor = .white
            //UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!{
        didSet {
             scoreLabel.text = GameballApp.clientBotStyle?.walletPointsName ?? GB_LocalizationsKeys.LeaderBoardScreen.score.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                scoreLabel.font = Fonts.cairoRegularFont10
                
            } else {
                scoreLabel.font = Fonts.montserratLightFont10
            }

        }
    }
    
    @IBOutlet weak var scoreValueLabel: UILabel!{
        didSet {
            // rankingNumberLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                scoreValueLabel.font = Fonts.cairoBoldFont12
                
            } else {
                scoreValueLabel.font = Fonts.montserratSemiBoldFont12
            }
            scoreValueLabel.textColor = Colors.appMainColor ?? .black
        }
    }
    
    var profile: Profile? {
        didSet {
            guard let profile = profile else { return }
            setProperties(with: profile)
        }
    }
    
    var rankNumber = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setProperties(with profile: Profile) {
        playerRank.text = profile.level?.name
        
        if profile.displayName == "" {
            playerName.text = "GameBall Player"

        } else {
            playerName.text = profile.displayName

        }
        rankingNumberLabel.text = "\(rankNumber)"
        
        if rankNumber == 1 || rankNumber == 2 || rankNumber == 3 {
            numbersView.backgroundColor =  Colors.appMainColor ?? .black
        }
        
        scoreValueLabel.text = "\(profile.accFrubies ?? 0)"
        
        let path = profile.level?.icon?.fileName ?? "https://s3.us-east-2.amazonaws.com/gameball-uat-bucket/uploads/Netsahem-UAT/616d1db1-e476-435d-b407-2ff5ff34d7bamedal@2x (1).png"
        //        path = "/" + path
        
        NetworkManager.shared().loadImage(path:path.replacingOccurrences(of: " ", with: "%20")) { (myImage, error) in
            if let errorModel = error {
                 Helpers().dPrint(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.playerImage.image = result
                }
            }
        }
    }
}
