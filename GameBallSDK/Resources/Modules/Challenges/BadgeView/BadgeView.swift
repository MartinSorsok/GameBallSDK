//
//  BadgeView.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/20/19.
//

import UIKit

class BadgeView: UICollectionViewCell, AchievementCellImageLoaderDelegate {

    @IBOutlet weak var achievementImageView: UIImageView!
 
    @IBOutlet weak var lockView: UIView!{
        didSet{
            lockView.translatesAutoresizingMaskIntoConstraints = false
            lockView.backgroundColor = Colors.appGray130
            lockView.layer.cornerRadius = lockView.frame.height / 2
        }
    }
    
    @IBOutlet weak var challengeNameUILabel: UILabel!{
        didSet {
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                challengeNameUILabel.font = Fonts.cairoRegularFont12

            } else {
                challengeNameUILabel.font = Fonts.montserratLightFont12

            }
        }
    }
    @IBOutlet weak var noOfAcheivedtimesView: UIView!{
        didSet {
            noOfAcheivedtimesView.isHidden = true
            noOfAcheivedtimesView.backgroundColor = Colors.appMainColor
            noOfAcheivedtimesView.layer.cornerRadius = noOfAcheivedtimesView.frame.size.width/2
            noOfAcheivedtimesView.clipsToBounds = true
        }
    }
    @IBOutlet weak var noOfAcheivedTimesLabel: UILabel!
    
    @IBOutlet weak var challengePointsUILabel: UILabel!{
        didSet {
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                challengePointsUILabel.font = Fonts.cairoBoldFont12

            } else {
                challengePointsUILabel.font = Fonts.montserratSemiBoldFont10

            }
        }
    }
//    
//    private let lockViewComponent: UIView = {
//        let iv = LockView(lockSize: .small)
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.clipsToBounds = true
//        iv.contentMode = .scaleAspectFit
//        return iv
//    }()
    var challenge: Challenge? {
        didSet {
            guard let challange = challenge else { return }
            setupAchievementAppearance(with: challange)
        }
    }

    var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
    }
    
    
    private func setupAchievementAppearance(with challenge: Challenge) {
        let isAchieved = (challenge.achievedCount ?? 0) > 0
        
        if isAchieved {
            achievementImageView.alpha = 1
        }
        else {
            achievementImageView.alpha = 0.5
        }
        if challenge.achievedCount ?? 0 > 1 {
            noOfAcheivedtimesView.isHidden = false
            noOfAcheivedTimesLabel.text = "\(challenge.achievedCount ?? 0)"
        } else {
            noOfAcheivedtimesView.isHidden = true 
        }
        if challenge.rewardPoints == 0 {
            challengePointsUILabel.text = ""

        } else {
            let amount = challenge.rewardPoints ?? 5
            let label = String(amount) + " " + (GameballApp.clientBotStyle?.walletPointsName ?? GB_LocalizationsKeys.GameballScreen.pts.rawValue.localized)
            challengePointsUILabel.text = label
        }


        lockView.isHidden = challenge.isUnlocked ?? false
        self.setChallengeName(with: challenge)
        
    }
    
    func setChallengeName(with challenge: Challenge) {
//        DispatchQueue.main.async {
            self.challengeNameUILabel.text = challenge.gameName
//        }
    }
    
    func setChallengeImage(fromModel: Challenge, index: Int) {
        let path = fromModel.icon ?? "assets/images/bolt.png"
        NetworkManager.shared().loadImage(path: path.replacingOccurrences(of: " ", with: "%20")) { (myImage, error) in
            if let errorModel = error {
                 Helpers().dPrint(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                self.didDownloadImage(fromModel: fromModel, index: index, image: result)
                
            }
        }
    }
    
    override func prepareForReuse() {
        self.achievementImageView.image = nil
    }
    
    func didDownloadImage(fromModel: Challenge, index: Int, image: UIImage) {
        if index == self.index {
            DispatchQueue.main.async {
                //                    self.stopAnimating()
                self.achievementImageView.image = image
//                                    self.achievementImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.achievementImageView.alpha = 0
//                UIView.animate(withDuration: 1.0, animations: {
                    let isAchieved = (fromModel.achievedCount ?? 0) > 0
                    if isAchieved {
                        self.achievementImageView.alpha = 1.0
                    }
                    else {
                        self.achievementImageView.alpha = 0.5
                    }
//                })
            }
        }
    }
    
}










