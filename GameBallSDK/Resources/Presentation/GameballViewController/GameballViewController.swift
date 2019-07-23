//
//  GameballViewController.swift
//  GameBallDemo
//
//  Created by Omar Ali on 2/1/19.
//  Copyright © 2019 Omar Ali. All rights reserved.
//

import UIKit

class GameballViewController: BaseViewController {
    
    

    
//
//    private let cellIdentifier = "Cell"
//    private let headerCollectionReusableView = "HeaderCollectionReusableView"
//    private let badgeViewView = "BadgeView"
//
//    private let challengesViewModel = ChallengesViewModel()
//
//    private var challenges: [Challenge] = []
//    private var quests: [Quest] = []
//
//

    

    
//
//    @IBOutlet private weak var collectionView: UICollectionView! {
//        didSet {
//            collectionView.dataSource = self
//            collectionView.delegate = self
//            collectionView.showsVerticalScrollIndicator = false
//            collectionView.register(UINib(nibName: headerCollectionReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCollectionReusableView)
//
//            collectionView.register(UINib(nibName: badgeViewView, bundle: nil), forCellWithReuseIdentifier: badgeViewView)
//
//        }
//    }
//
    
//    public init() {
//        let b = Bundle.init(for: type(of: self))
//        super.init(nibName: "GameballViewController", bundle: Bundle.init(for: type(of: self)))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override public func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = true
//        fetchData()
//    }
//    
//    private func fetchData(completion: (()->())? = nil) {
//        startLoading()
//        getSettings(completion: {
//                self.getChallenges(completion: {
//                    DispatchQueue.main.async {
//                        self.endLoading()
//
//                    }
//                })
//            
//        })
//    }
//    
//    private func getChallenges(completion: @escaping () -> Void) {
//
//        
//        challengesViewModel.getAllChallenges { (error) in
//            if error != nil {
//                print(error?.description as Any)
//            }
//            else {
//                // ToDo: stop animation
//                self.challenges = self.challengesViewModel.challenges
//                self.quests = self.challengesViewModel.quests
//                
//                completion()
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            }
//        }
//        
//    }
//    
//    private func getSettings(completion: @escaping () -> Void) {
//        let settingsViewModel = ClientBotSettingsViewModel()
//        settingsViewModel.getClientBotStyle(completion: {
//            error in
//            if error != nil {
//                // handle error
//            }
//            else {
//                GameballApp.clientBotStyle = settingsViewModel.botStyle
//                completion()
//            }
//        })
//    }
//
//}
//
//extension GameballViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    public func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1 + self.quests.count
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if (section == 0) {
//            return self.challenges.count
//        }
//        else {
//            return self.quests[section-1].questChallenges?.count ?? 0
//        }
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: badgeViewView, for: indexPath) as! BadgeView
//            let challenge = self.challenges[indexPath.row]
//            cell.challenge = challenge
//            cell.index = indexPath.row
//            cell.setChallengeImage(fromModel: challenge, index: indexPath.row)
//            cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//
//            return cell
//
//        }
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: badgeViewView, for: indexPath) as! BadgeView
//        if let challenge = self.quests[indexPath.section-1].questChallenges?[indexPath.row] {
//            cell.challenge = challenge
//            cell.index = indexPath.row
//            cell.setChallengeImage(fromModel: challenge,  index: indexPath.row)
//        }
//         return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 1.5, delay: 0.04, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {
//            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//
//            self.view.layoutIfNeeded()
//
//        }, completion: nil)
//    }
//

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
//    }
//
//
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.frame.width - 70) / 3
//        return CGSize(width: width, height: width + 20)
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
    
    
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            // ToDo: init vc based on challenge
//            let challenge = challenges[indexPath.row]
//            if challenge.challengeType == .Highscore {
//                let vc = AchivementHighscoreViewController()
//                vc.challenge = challenge
//                push(vc, animated: true)
//            }
//            else {
//                if challenge.milestones?.count ?? 0 > 0 {
//                    let vc = ActionBasedViewController();
//                    vc.challenge = challenge
//                    push(vc, animated: true)
//                }
//                else {
//                    let vc = ActionBasedWithoutMilestonesViewController();
//                    vc.challenge = challenge
//                    push(vc, animated: true)
//                }
//            }
//        }
//        else {
//            if let challenge = quests[indexPath.section-1].questChallenges?[indexPath.row] {
//                let vc = AchievementDetailsViewController(challenge: challenge)
//                push(vc, animated: true)
//            }
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        viewForSupplementaryElementOfKind kind: String,
//                        at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
//
//        case UICollectionView.elementKindSectionHeader:
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCollectionReusableView, for: indexPath)
//
//            headerView.backgroundColor = UIColor.blue
//            return headerView
//
//
//
//        default:
//            assert(false, "Unexpected element kind")
//        }
//        return UICollectionReusableView()
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 30.0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if section ==  self.quests.count {
//        return CGSize(width: UIScreen.main.bounds.width, height: 42.0)
//        }
//
//        return CGSize(width: 0.0, height: 0.0)
//    }


}

//extension GameballViewController: DropdownViewDelegate {
//    func dropdownView(_ dropdownView: DropdownView, didSelectItemAt index: Int, for string: String) {
//        if index == 1 {
//            let vc = LeaderboardViewController()
//            push(vc, animated: true)
//        }
//    }
//}







