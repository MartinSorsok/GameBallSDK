//
//  ParentViewController.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 3/17/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    func dataReady(collectionView: UICollectionView)
    func dataReady(tableview: UITableView)
    func shareText(text: String)
    func challengeTapped(with challenge: Challenge)
    
}
protocol ProfileHeaderViewDelegate: AnyObject {
    func dataReady(view: UIView)
}


protocol TabIconHeaderDelegate: AnyObject {
    func cellTapped(feature: Int)
}
class ParentViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!{
        didSet {
            mainTableView.dataSource = self
            mainTableView.delegate = self
            
            mainTableView.register(UINib(nibName: mainTableViewCell, bundle: nil), forCellReuseIdentifier: mainTableViewCell)
            mainTableView.register(UINib(nibName: badgesCollectionViewinCell, bundle: nil), forCellReuseIdentifier: badgesCollectionViewinCell)
            mainTableView.register(UINib(nibName: challengesTableViewInCell, bundle: nil), forCellReuseIdentifier: challengesTableViewInCell)
            
            
            mainTableView.register(UINib(nibName: tabIconsHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: tabIconsHeader)
            
            mainTableView.rowHeight = UITableView.automaticDimension
            mainTableView.estimatedRowHeight = 600
            mainTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet private weak var profileHeaderView: ProfileHeaderView!
    
    let userCache = UserProfileCache.get()
    private let mainTableViewCell = "MainTableViewCell"
    private let badgesCollectionViewinCell = "BadgesCollectionViewinCell"
    private let tabIconsHeader = "TabIconsHeader"
    private let challengesTableViewInCell = "ChallengesTableViewInCell"
    private var  currentFeature = 0
    private let challengesViewModel = ChallengesViewModel()
    
    private var challenges: [Challenge] = []
    private var quests: [Quest] = []
    private var collectionViewHeight = CGFloat(0)
    private var tableViewHeight = CGFloat(0)
    
    @IBOutlet weak var weRunOnLabel: UILabel!{
        didSet{
            weRunOnLabel.text = LocalizationsKeys.General.gameballFooterText.rawValue.localized
            weRunOnLabel.textColor = Colors.appGray153
            
            if Localizator.sharedInstance.language == Languages.arabic {
                weRunOnLabel.font = Fonts.cairoRegularFont12
            } else {
                weRunOnLabel.font = Fonts.montserratLightFont12
            }
        }
    }
    
    @IBOutlet weak var gameBallLabel: UILabel!{
        didSet{
            gameBallLabel.text = "Gameball"
            gameBallLabel.textColor = Colors.appGray153
            if Localizator.sharedInstance.language == Languages.arabic {
                gameBallLabel.font = Fonts.cairoBoldFont12
            } else {
                gameBallLabel.font = Fonts.montserratSemiBoldFont10
            }
        }
    }
    
    
    public init() {
        _ = Bundle.init(for: type(of: self))
        super.init(nibName: "ParentViewController", bundle: Bundle.init(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHeaderView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.startLoading()
    }
    
    
    @IBAction func gameBallTapped(_ sender: UITapGestureRecognizer) {
        //
        //        if let url = NSURL(string: GameballApp.clientBotStyle?.buttonLink ?? "https://www.gameball.co"){
        if let url = NSURL(string: "https://www.gameball.co"){
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
            
        } else {
            
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: tabIconsHeader) as! TabIconsHeader
        headerView.delegate = self
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: mainTableViewCell) as! MainTableViewCell
            return cell
        } else if indexPath.section == 1{
            
            if currentFeature == Features.Profile.rawValue {
                let cell = tableView.dequeueReusableCell(withIdentifier: badgesCollectionViewinCell) as! BadgesCollectionViewinCell
                cell.delegate = self
                cell.frame = tableView.bounds;  // cell of myTableView
                cell.currentFeature = self.currentFeature
                cell.collectionViewHeight.constant = collectionViewHeight;
                cell.collectionView.reloadData()
                return cell
                
            } else if currentFeature == Features.FriendReferal.rawValue || currentFeature == Features.LeaderBoard.rawValue {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: challengesTableViewInCell) as! ChallengesTableViewInCell
                cell.delegate = self
                cell.frame = tableView.bounds;  // cell of myTableView
                cell.currentFeature = self.currentFeature
                //            cell.tableViewHeightConstraint.constant = tableViewHeight
                cell.tableView.reloadData()
                return cell
            }
        }
        
        return UITableViewCell()
    }
}


extension ParentViewController: TabBarDelegate {
    func challengeTapped(with challenge: Challenge) {
        let vc = ChallengeDetailsViewController()
        vc.challenge = challenge
        push(vc, animated: true)
        
    }
    
    func shareText(text: String) {
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func dataReady(tableview: UITableView) {
        self.endLoading()
        
        DispatchQueue.main.async {
            
            self.mainTableView.reloadData()
            self.mainTableView.layoutIfNeeded()
            
        }
        
    }
    
    func dataReady(collectionView: UICollectionView){
        self.endLoading()
        
        DispatchQueue.main.async {
            self.collectionViewHeight =  collectionView.collectionViewLayout.collectionViewContentSize.height
            self.mainTableView.reloadData()
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            collectionView.isHidden = false
            collectionView.reloadData()
            
        })
        
    }
    
    
    
}


extension ParentViewController: TabIconHeaderDelegate{
    func cellTapped(feature: Int) {
        print(feature)
        self.startLoading()
        
        nc.post(name: Notification.Name("tabBarTapped"), object: feature)
        self.currentFeature = feature
        
        self.mainTableView.reloadData()
    }
    
    
    
    
}


extension ParentViewController: ProfileHeaderViewDelegate{
    func dataReady(view: UIView) {
        
    }
}
