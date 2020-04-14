//
//  GB_MissionsTableViewCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 10/19/19.
//

import UIKit

class GB_MissionsTableViewCell: UITableViewCell {

    var cellExpanded = false
    private let challengeInMissionTableViewCell = "GB_ChallengeInMissionTableViewCell"
    weak var delegate:TabBarDelegate?

    @IBOutlet weak var cellHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var challengesTableViewHeightConstraint: NSLayoutConstraint!
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
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                challengeTitleLabel.font = Fonts.cairoBoldFont12
                
            } else {
                challengeTitleLabel.font = Fonts.montserratSemiBoldFont12
            }
        }
    }
    
    @IBOutlet weak var giftImageScore: UIImageView!
    @IBOutlet weak var rewardLabel: UILabel!{
        didSet{
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                rewardLabel.font = Fonts.cairoBoldFont12
                
            } else {
                rewardLabel.font = Fonts.montserratSemiBoldFont10
            }
        }
    }
    
    @IBOutlet weak var challengesTableView: UITableView!{
        didSet {
            challengesTableView.dataSource = self
            challengesTableView.delegate = self

            challengesTableView.register(UINib(nibName: challengeInMissionTableViewCell, bundle: nil), forCellReuseIdentifier: challengeInMissionTableViewCell)
 
            
    
            challengesTableView.rowHeight = UITableView.automaticDimension
            challengesTableView.estimatedRowHeight = 600
            challengesTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var noOfChallengesInMission: UILabel!{
        didSet{
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                noOfChallengesInMission.font = Fonts.cairoBoldFont10
                
            } else {
                noOfChallengesInMission.font = Fonts.montserratSemiBoldFont10
            }
            noOfChallengesInMission.textColor = Colors.appMainColor ?? .black
        }
    }
    @IBOutlet weak var percentageOfMission: UILabel!{
        didSet{
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                percentageOfMission.font = Fonts.cairoBoldFont8
                
            } else {
                percentageOfMission.font = Fonts.montserratSemiBoldFont8
            }
        }
    }
    
    @IBOutlet weak var achievedImage: UIImageView!
    
    @IBOutlet weak var progressView: ProgressView!{
        didSet{

        }
        
    }
    
    var quest :Quest? {
        didSet{
            challengeTitleLabel.text = quest?.questName
            setImage(withURL: quest?.icon ?? "https://assets.gameball.co/sample/4.png" )
            
            
            if quest?.rewardPoints == 0 && quest?.rewardFrubies == 0  {
                rewardLabel.text = ""
                giftImageScore.isHidden = true
                
            } else if quest?.rewardPoints == 0 {
                rewardLabel.text = "\(quest?.rewardFrubies ?? 0) \(GameballApp.clientBotStyle?.rankPointsName ?? "")"
            }  else if quest?.rewardFrubies == 0 {
                rewardLabel.text = "\(quest?.rewardPoints ?? 0) \(GameballApp.clientBotStyle?.walletPointsName ?? "")"
            }  else {
                rewardLabel.text = "\(quest?.rewardFrubies ?? 0) \(GameballApp.clientBotStyle?.rankPointsName ?? "") | \(quest?.rewardPoints ?? 0) \(GameballApp.clientBotStyle?.walletPointsName ?? "")"
            }

            
            
            
            
        //    rewardLabel.text = "\(quest?.rewardFrubies ?? 0) Score | \(quest?.rewardPoints ?? 0) points"
            
            noOfChallengesInMission.text = "\(quest?.questChallenges?.count ?? 0) " + GB_LocalizationsKeys.GameballScreen.challenges.rawValue.localized
            let percentageFilled = quest?.completionPercentage ?? 0.0
            
            if percentageFilled == 1 {
               achievedImage.image = UIImage(named: "CheckmarkNew.png")
                percentageOfMission.text = ""
            } else {
                percentageOfMission.text = "\(Int(percentageFilled * 100))%"
            }
            
            
            
            let color = Colors.appMainColor ?? .black
            progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: color, percentageFilled: percentageFilled)
            self.challengesTableView.reloadData()

        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
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

extension  GB_MissionsTableViewCell: UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quest?.questChallenges?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if quest?.questChallenges?.count ?? 0 > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: challengeInMissionTableViewCell) as! GB_ChallengeInMissionTableViewCell
            cell.selectionStyle = .none
            Helpers().dPrint("******** \(indexPath.row)")
            cell.challenge = quest?.questChallenges?[indexPath.row]
            
            if quest?.isOrdered ?? false {
                cell.nextChallengeArrowImage.isHidden = false
            } else {
                cell.nextChallengeArrowImage.isHidden = true
                
            }
            if indexPath.row == ((quest?.questChallenges?.count ?? 0) - 1)  {
                cell.nextChallengeArrowImage.isHidden = true
            }
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  quest?.questChallenges?.count ?? 0 > 0 {
            guard let challenge = quest?.questChallenges?[indexPath.row] else {return}
                   delegate?.challengeTapped(with: challenge)
        }

    }
}
