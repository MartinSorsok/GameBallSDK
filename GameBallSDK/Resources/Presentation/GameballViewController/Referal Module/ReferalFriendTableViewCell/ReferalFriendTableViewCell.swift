//
//  ReferalFriendTableViewCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/27/19.
//

import UIKit

class ReferalFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.clipsToBounds = true
            containerView.layer.cornerRadius = 5
            containerView.layer.borderColor = Colors.appGray242.cgColor
            containerView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var challengeImage: UIImageView!
    
    @IBOutlet weak var challengeTitleLabel: UILabel!{
        didSet{
            if Localizator.sharedInstance.language == Languages.arabic {
                challengeTitleLabel.font = Fonts.cairoRegularFont12
                
            } else {
                challengeTitleLabel.font = Fonts.montserratLightFont12
            }
        }
    }
    
    @IBOutlet weak var rewardLabel: UILabel!{
        didSet{
            if Localizator.sharedInstance.language == Languages.arabic {
                rewardLabel.font = Fonts.cairoBoldFont12
                
            } else {
                rewardLabel.font = Fonts.montserratSemiBoldFont10
            }
        }
    }
    
    @IBOutlet weak var numberOfAchievedLabel: UILabel!{
        didSet{
            if Localizator.sharedInstance.language == Languages.arabic {
                numberOfAchievedLabel.font = Fonts.cairoRegularFont12
                
            } else {
                numberOfAchievedLabel.font = Fonts.montserratLightFont12
            }
        }
    }
    
    @IBOutlet weak var achievedImage: UIImageView!
    
    @IBOutlet weak var progressView: ProgressView!{
        didSet{

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
            
            rewardLabel.text = "\(challenge?.rewardFrubies ?? 0) Score | \(challenge?.rewardPoints ?? 0) points"
            
            
            let percentageFilled = Float((challenge?.actionsAndAmountCompletedPercentage ?? 0) / 100 )
            
            let color = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
            progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: color!, percentageFilled: percentageFilled)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        numberOfAchievedLabel.isHidden = true
        
        
        
        

    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage(withURL: String) {
        let path = withURL
        NetworkManager.shared().loadImage(path: path.replacingOccurrences(of: " ", with: "%20")) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
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