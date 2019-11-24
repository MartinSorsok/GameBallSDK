//
//  TabBar.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/22/19.
//

import UIKit

class BadgesCollectionViewinCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    private let badgeViewView = "BadgeView"
    private let headerCollectionReusableView = "HeaderCollectionReusableView"

    private let challengesViewModel = ChallengesViewModel()
     var  currentFeature = 0
    private var challenges: [Challenge] = []
    private var quests: [Quest] = []
    weak var delegate:TabBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isHidden = true

//        self.collectionView.register(UINib.init(nibName: "TabbarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TabbarCollectionViewCell")
             collectionView.register(UINib(nibName: badgeViewView, bundle: nil), forCellWithReuseIdentifier: badgeViewView)
                    collectionView.register(UINib(nibName: headerCollectionReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCollectionReusableView)
        collectionView.register(UINib(nibName: headerCollectionReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: headerCollectionReusableView)

        fetchData()
    }
    
    private func fetchData(completion: (()->())? = nil) {
        getSettings(completion: {
            self.getChallenges(completion: {
                DispatchQueue.main.async {
                    
//                    self.endLoading()
                    
                }
            })
            
        })
        
    }
    private func getChallenges(completion: @escaping () -> Void) {
        
        
        challengesViewModel.getAllChallenges { (error) in
            if error != nil {
                 Helpers().dPrint(error?.description as Any)
            }
            else {
                // ToDo: stop animation
                self.challenges = self.challengesViewModel.challenges
                self.quests = self.challengesViewModel.quests
                
                completion()
                DispatchQueue.main.async {

                    self.collectionView.reloadData()
                }
                self.delegate?.dataReady(collectionView: self.collectionView)

                
            }
        }
        
    }
    
    private func getSettings(completion: @escaping () -> Void) {
        let settingsViewModel = ClientBotSettingsViewModel()
        settingsViewModel.getClientBotStyle(completion: {
            error in
            if error != nil {
                // handle error
            }
            else {
                GameballApp.clientBotStyle = settingsViewModel.botStyle
                completion()
            }
        })
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Configure the view for the selected state

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1 + self.quests.count
        return 1

    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0) {
            return self.challenges.count
        }
        else {
            //return self.quests[section-1].questChallenges?.count ?? 0
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: badgeViewView, for: indexPath) as! BadgeView
            let challenge = self.challenges[indexPath.row]
            cell.challenge = challenge
            cell.index = indexPath.row
            cell.setChallengeImage(fromModel: challenge, index: indexPath.row)
            cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: badgeViewView, for: indexPath) as! BadgeView
        //        if let challenge = self.quests[indexPath.section-1].questChallenges?[indexPath.row] {
        //            cell.challenge = challenge
        //            cell.index = indexPath.row
        //            cell.setChallengeImage(fromModel: challenge,  index: indexPath.row)
        //        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 1.5, delay: 0.04, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            self.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    
    
    

    
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {

        case UICollectionView.elementKindSectionHeader:
            

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCollectionReusableView, for: indexPath) as? HeaderCollectionReusableView

            if self.challenges.count > 0 {
            headerView?.titleLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            } else {
               headerView?.titleLabel.text = ""
            }
            
            return headerView ?? UICollectionReusableView()
            

        case UICollectionView.elementKindSectionFooter:
              

              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCollectionReusableView, for: indexPath)  as? HeaderCollectionReusableView

              if self.quests.count > 0 {
              headerView?.titleLabel.text =  LocalizationsKeys.GameballScreen.missionsTitle.rawValue.localized
              } else {
                 headerView?.titleLabel.text = ""
              }
              return headerView ?? UICollectionReusableView()
              
        default:
            assert(false, "Unexpected element kind")
        }
       return  UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        

        return CGSize(width: collectionView.frame.width, height: 58.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
         

         return CGSize(width: collectionView.frame.width, height: 58.0)
     }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let challenge = challenges[indexPath.row]
        delegate?.challengeTapped(with: challenge)
    }
    
}


    



protocol AchievementCellImageLoaderDelegate {

    // should take the index path
    func didDownloadImage(fromModel: Challenge, index: Int, image: UIImage)
}



