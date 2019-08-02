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
            
            if Localizator.sharedInstance.language == Languages.arabic {
                challengeNameUILabel.font = Fonts.cairoRegularFont12

            } else {
                challengeNameUILabel.font = Fonts.montserratLightFont12

            }
        }
    }
    
    @IBOutlet weak var challengePointsUILabel: UILabel!{
        didSet {
            if Localizator.sharedInstance.language == Languages.arabic {
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
        let amount = challenge.rewardPoints ?? 5
        let label = String(amount) + LocalizationsKeys.GameballScreen.pts.rawValue.localized
        challengePointsUILabel.text = label

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
                print(errorModel.description)
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

//class AchievementCell: UICollectionViewCell, AchievementCellImageLoaderDelegate {
//
//
//
//
//

//
//    private let challengeNameUILabel: UILabel = {
//        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
//        label.textColor = Colors.appGray74
//        label.textAlignment = .center
//        label.text = "This is two lines name"
//        label.numberOfLines = 0
//        label.font = label.font.withSize(11)
//        return label
//    }()
//
//    private let challengePointsUILabel: UILabel = {
//        let label = UILabel.init(frame: CGRect(x: -45, y: 87, width: 200, height: 30))
//        label.textColor = Colors.appGray74
//        label.textAlignment = .center
//        label.text = "30 pts"
//        label.numberOfLines = 1
//        label.font = Fonts.achievementCellPointsFont
//        return label
//    }()
//
//    private let activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
//        indicator.isHidden = true
//        return indicator
//    }()
//

//        private let lockView: UIView = {
//let iv = LockView(lockSize: .small)
//iv.translatesAutoresizingMaskIntoConstraints = false
//iv.clipsToBounds = true
//iv.contentMode = .scaleAspectFit
//return iv
//}()

//
////    private func addSubViews() {
////        contentView.addSubview(achievementImageView)
////        contentView.addSubview(lockView)
////        contentView.addSubview(challengeNameUILabel)
////        contentView.addSubview(challengePointsUILabel)
////        contentView.addSubview(activityIndicator)
////    }
////
////    private func addConstraints() {
////
////        achievementImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
////        achievementImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
////        achievementImageView.heightAnchor.constraint(equalTo: achievementImageView.widthAnchor, multiplier: 1).isActive = true
////        achievementImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////
////        challengeNameUILabel.topAnchor.constraint(equalTo: achievementImageView.bottomAnchor, constant: 0).isActive = true
////        challengeNameUILabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////        challengeNameUILabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
////        challengeNameUILabel.frame = CGRect(x: 0, y: contentView.frame.height - 50, width: contentView.frame.width, height: 30)
////
////        challengePointsUILabel.topAnchor.constraint(equalTo: challengeNameUILabel.bottomAnchor, constant: 4).isActive = true
////        challengePointsUILabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////        challengePointsUILabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
////        challengePointsUILabel.frame = CGRect(x: 0, y: contentView.frame.height - 20, width: contentView.frame.width, height: 30)
////
////        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
////
////        lockView.topAnchor.constraint(equalTo: achievementImageView.topAnchor).isActive = true
////        lockView.trailingAnchor.constraint(equalTo: achievementImageView.trailingAnchor).isActive = true
////        lockView.heightAnchor.constraint(equalToConstant: 21.4).isActive = true
////        lockView.widthAnchor.constraint(equalToConstant: 21.4).isActive = true
////
////    }
//
//
//
//
//
//}
//
//









