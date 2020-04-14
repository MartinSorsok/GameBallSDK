//
//  ParentViewController.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 3/17/19.
//  Copyright © 2019 Martin Sorsok. All rights reserved.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    func dataReady(collectionView: UICollectionView)
    func dataReady(tableview: UITableView)
    func shareText(text: String)
    func challengeTapped(with challenge: Challenge)
    func tappedLeaderBoardFilter()
    
    
}
protocol ProfileHeaderViewDelegate: AnyObject {
    func dataReady(view: UIView)
}


protocol TabIconHeaderDelegate: AnyObject {
    func cellTapped(feature: Int)
}
class ParentViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var closeButton: UIButton!{
        didSet {
            if GameballApp.clientBotStyle?.isRankPointsVisible == false  && GameballApp.clientBotStyle?.isWalletPointsVisible == false  {
                  let origImage = UIImage(named: "icon_outline_14px_close@2x.png")
                     
            } else {
                let origImage = UIImage(named: "icon_outline_14px_close@2x.png")
                         let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                         closeButton.setImage(tintedImage, for: .normal)
                         closeButton.tintColor = .white
            }
         
        }
    }
    var isEmbedType = false
    
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var mainTableView: UITableView!{
        didSet {
            mainTableView.dataSource = self
            mainTableView.delegate = self
            
            mainTableView.register(UINib(nibName: mainTableViewCell, bundle: nil), forCellReuseIdentifier: mainTableViewCell)
            mainTableView.register(UINib(nibName: badgesCollectionViewinCell, bundle: nil), forCellReuseIdentifier: badgesCollectionViewinCell)
            mainTableView.register(UINib(nibName: challengesTableViewInCell, bundle: nil), forCellReuseIdentifier: challengesTableViewInCell)
            mainTableView.register(UINib(nibName: missionsTableViewCell, bundle: nil), forCellReuseIdentifier: missionsTableViewCell)
            
            
            mainTableView.register(UINib(nibName: tabIconsHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: tabIconsHeader)
            
            mainTableView.rowHeight = UITableView.automaticDimension
            mainTableView.estimatedRowHeight = 600
            mainTableView.tableFooterView = UIView()
            
            
            let attributes = [NSAttributedString.Key.foregroundColor: Colors.appMainColor ?? .black]
            let attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
            refreshControl.attributedTitle = attributedTitle
            refreshControl.tintColor = Colors.appMainColor ?? .black
            refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
            mainTableView.addSubview(refreshControl) // not required when using UITableViewController
        }
    }
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        setupLogic()
        self.endLoading()
        
        refreshControl.endRefreshing()
    }
    @IBOutlet private weak var profileHeaderView: ProfileHeaderView!
    
    let userCache = UserProfileCache.get()
    private let mainTableViewCell = "MainTableViewCell"
    private let badgesCollectionViewinCell = "BadgesCollectionViewinCell"
    private let tabIconsHeader = "TabIconsHeader"
    private let challengesTableViewInCell = "ChallengesTableViewInCell"
    private let missionsTableViewCell = "GB_MissionsTableViewCell"
    
    private var  currentFeature = 0
    private let challengesViewModel = ChallengesViewModel()
    
    private var challenges: [Challenge] = []
    private var quests: [Quest] = []
    var leaderboardProfiles: [Profile] = []
    private var playerRank: LeaderboardPlayerRank?
    
    private var notifications: [NotificationGB] = []
    private var filteredString = "All"
    private var collectionViewHeight = CGFloat(0)
    private var tableViewHeight = CGFloat(0)
    
    var choices = ["Today","Yesterday","This Week","Last Week","This Month","Last Month","This Year","All"]
    var pickerView = UIPickerView()
    var typeValue = String()
    
    
    
    @IBOutlet weak var weRunOnLabel: UILabel!{
        didSet{
            weRunOnLabel.text = GB_LocalizationsKeys.General.gameballFooterText.rawValue.localized
            weRunOnLabel.textColor = Colors.appGray153
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                weRunOnLabel.font = Fonts.cairoRegularFont12
            } else {
                weRunOnLabel.font = Fonts.montserratLightFont12
            }
        }
    }
    @IBOutlet weak var closeTopView: UIView!{
        didSet {
            if GameballApp.clientBotStyle?.isRankPointsVisible == false  && GameballApp.clientBotStyle?.isWalletPointsVisible == false  {
                closeTopView.backgroundColor = .white
            } else {
                closeTopView.backgroundColor = Colors.appMainColor
                
            }
            
        }
    }
    
    @IBOutlet weak var topView: UIView!{
        didSet {
            
            if GameballApp.clientBotStyle?.isRankPointsVisible == false  && GameballApp.clientBotStyle?.isWalletPointsVisible == false  {
                topView.backgroundColor = .white
            } else {
                topView.backgroundColor = Colors.appMainColor
                
            }
        }
    }
    @IBOutlet weak var gameBallLabel: UILabel!{
        didSet{
            gameBallLabel.text = "Gameball"
            gameBallLabel.textColor = Colors.appGray153
            if GB_Localizator.sharedInstance.language == Languages.arabic {
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
        setupLogic()
    }
    
    private func setupLogic() {
        profileHeaderView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
        self.startLoading()
        fetchNotificationsData()
        getChallenges()
        fetchLeaderBoardDate(withLimit: 8)
        
        if isEmbedType {
            closeButton.isHidden = true
        } else {
            closeButton.isHidden = false
        }
        
        nc.addObserver(self,selector: #selector(StartCurrentFeature), name: Notification.Name("StartcurrentFeature"), object: nil)
        nc.post(name: Notification.Name("refresh"), object: nil)
        
    }
    
    
    
    
    
    
    @objc func StartCurrentFeature(_ notification:Notification) {
        // self.delegate?.dataReady(tableview: self.tableView)
        
        guard let featureNumber = notification.object as? Int else {
            return
        }
        
        self.startLoading()
        nc.post(name: Notification.Name("tabBarTapped"), object: featureNumber)
        self.currentFeature = featureNumber
        self.mainTableView.reloadData()
        
        
        
    }
    
    private func fetchNotificationsData() {
        //        startLoading()
        let viewModel = NotificationsViewModel()
        viewModel.getNotifications(completion: {
            [weak self] error in
            if error != nil {
                // handle error
                //                self?.endLoading()
                return
            }
            
            self?.notifications = viewModel.notifications
            
        })
    }
    private func getChallenges() {
        
        challengesViewModel.getAllChallenges { (error) in
            if error != nil {
                Helpers().dPrint(error?.description as Any)
            }
            else {
                self.challenges = self.challengesViewModel.challenges.filter {
                    $0.isReferral ?? false
                }
                self.quests = self.challengesViewModel.quests
            }
        }
        
    }
    
    private func fetchLeaderBoardDate(withLimit: Int) {
        let viewModel = LeaderboardViewModel()
        viewModel.getLeaderboard(withLimit: withLimit, completion: {
            [weak self] error in
            if error != nil {
                return
            }
            self?.leaderboardProfiles = viewModel.leaderboardPlayerBot?.playerBot ?? []
            self?.playerRank = viewModel.leaderboardPlayerBot?.playerRank
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
            
            
        })
        
        
    }
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.mainTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    @IBAction func gameBallTapped(_ sender: UITapGestureRecognizer) {
        //
        //        if let url = NSURL(string: GameballApp.clientBotStyle?.buttonLink ?? "https://www.gameball.co"){
        if let url = NSURL(string: "https://www.gameball.co/landing_mobile/?utm_source=Mobile%20apps&utm_medium=Mobile%20footer&utm_campaign=Mobile%20users"){
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 && quests.count > 0 && currentFeature == Features.Profile.rawValue {
            return quests.count + 1
        } else {
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0  {
            return 0.0
        } else if isOneTabBar() {
            return 0.1
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
        
        
        if indexPath.row == 0 && indexPath.section == 0 && (UserDefaults.standard.object(forKey: UserDefaultsKeys.APIKey.rawValue) as? String != "d58a919179834f1583b66edd1c10f9bd")  {
            let cell = tableView.dequeueReusableCell(withIdentifier: mainTableViewCell) as! MainTableViewCell
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 1{
            
            if currentFeature == Features.Profile.rawValue {
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: badgesCollectionViewinCell) as! BadgesCollectionViewinCell
                    cell.delegate = self
                    cell.frame = tableView.bounds;  // cell of myTableView
                    cell.currentFeature = self.currentFeature
                    cell.collectionViewHeight.constant = collectionViewHeight;
                    cell.collectionView.reloadData()
                    cell.selectionStyle = .none
                    return cell
                } else  {
                    
                    //                    if quests.count > 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: missionsTableViewCell) as! GB_MissionsTableViewCell
                    
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.quest = quests[indexPath.row - 1]
                    return cell
                    //                    }
                    
                    
                }
            } else if currentFeature == Features.FriendReferal.rawValue || currentFeature == Features.LeaderBoard.rawValue || currentFeature == Features.Notifications.rawValue{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: challengesTableViewInCell) as! ChallengesTableViewInCell
                cell.delegate = self
                cell.currentFeature = self.currentFeature
                cell.notifications = self.notifications
                cell.challenges = self.challenges
                cell.leaderboardProfiles = self.leaderboardProfiles
                cell.playerRank = self.playerRank
                cell.filteredString = self.filteredString
                cell.frame = tableView.bounds;  // cell of myTableView
                
                cell.tableView.reloadData()
                cell.layoutIfNeeded()
                cell.tableView.layoutIfNeeded()
                
                cell.tableView.isHidden = false
                cell.layoutIfNeeded()
                cell.tableViewHeightConstraint.constant = cell.tableView.contentSize.height
                cell.layoutIfNeeded()
                
                cell.selectionStyle = .none
                
                self.endLoading()
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let cell = tableView.cellForRow(at: indexPath) as? GB_MissionsTableViewCell {
            
            let noOfChallenges = quests[indexPath.row - 1].questChallenges?.count ?? 0
            
            if cell.cellExpanded {
                cell.cellExpanded = false
                cell.challengesTableViewHeightConstraint.constant = 0
            } else {
                cell.cellExpanded = true
                cell.challengesTableViewHeightConstraint.constant = CGFloat(55 * noOfChallenges)
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GB_MissionsTableViewCell {
            cell.challengesTableViewHeightConstraint.constant = 0
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}


extension ParentViewController: TabBarDelegate ,UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        self.typeValue = choices[row]
        
        Helpers().dPrint(choices[row])
    }
    
    
    func tappedLeaderBoardFilter() {
        let alert = UIAlertController(title: "Filter Choices", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            if self.typeValue == "" {
                self.typeValue = "Today"
            }
            self.filteredString = self.typeValue
            Helpers().dPrint("You selected " + self.typeValue )
            Helpers().dPrint((self.choices.firstIndex(of: self.typeValue) ?? 7) + 1)
            
            self.fetchLeaderBoardDate(withLimit: (self.choices.firstIndex(of: self.typeValue) ?? 7) + 1)
            
            
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    func challengeTapped(with challenge: Challenge) {
        let vc = ChallengeDetailsViewController()
        vc.isTypeEmbed = isEmbedType
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
        
        //        DispatchQueue.main.async {
        //            self.tableViewHeight = tableview.contentSize.height
        //        tableview.isHidden = false
        
        self.mainTableView.reloadData()
        
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
        //
        //
        //        })
        
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
        Helpers().dPrint(feature)
        self.startLoading()
        nc.post(name: Notification.Name("tabBarTapped"), object: feature)
        self.currentFeature = feature
        self.mainTableView.reloadData()
        scrollToFirstRow()
    }
}


extension ParentViewController: ProfileHeaderViewDelegate{
    func dataReady(view: UIView) {
        
    }
}
