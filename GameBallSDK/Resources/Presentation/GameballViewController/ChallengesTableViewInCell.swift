//
//  ChallengesTableViewInCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/27/19.
//

import UIKit

class ChallengesTableViewInCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    
    
    var referalHeaderViewTableView = "ReferalHeaderViewTableView"
    var referalFriendTableViewCell = "ReferalFriendTableViewCell"
    
    var leaderBoardTableViewCell = "LeaderBoardTableViewCell"
    var leaderBoardHeaderView = "LeaderBoardHeaderView"
    
    var sharingCodeText = ""
    private var challenges: [Challenge] = []
    private var leaderboardProfiles: [Profile] = []
    
    weak var delegate:TabBarDelegate?
    private let challengesViewModel = ChallengesViewModel()
    var  currentFeature = 1
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.separatorStyle = .none
            tableView.dataSource = self
            tableView.delegate = self
            tableView.showsVerticalScrollIndicator = false
            tableView.register(UINib(nibName: referalFriendTableViewCell, bundle: nil), forCellReuseIdentifier: referalFriendTableViewCell)
            tableView.register(UINib(nibName: referalHeaderViewTableView, bundle: nil), forHeaderFooterViewReuseIdentifier: referalHeaderViewTableView)
            
            tableView.register(UINib(nibName: leaderBoardTableViewCell, bundle: nil), forCellReuseIdentifier: leaderBoardTableViewCell)
            tableView.register(UINib(nibName: leaderBoardHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: leaderBoardHeaderView)
            
            
        }
    }
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nc.addObserver(self, selector: #selector(tabBarTapped), name: Notification.Name("tabBarTapped"), object: nil)
        fetchLeaderBoardDate()
        fetchData()
        
    }
    
    @objc func tabBarTapped(_ notification:Notification) {
        
        guard let featureNumber = notification.object as? Int else {
            return
        }
        
        switch featureNumber {
        case Features.LeaderBoard.rawValue:
            fetchLeaderBoardDate()
        default:
            fetchData()
        }
        print(featureNumber)
        
    }
    private func fetchLeaderBoardDate() {
        //        startLoading()
        let viewModel = LeaderboardViewModel()
        viewModel.getLeaderboard(completion: {
            [weak self] error in
            if error != nil {
                // handle error
                //                self?.endLoading()
                return
            }
            
            self?.leaderboardProfiles = viewModel.leaderboard
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
                self?.tableView.layoutIfNeeded()
                
                self?.tableViewHeightConstraint.constant = self?.tableView.contentSize.height ?? 0.0
                self?.delegate?.dataReady(tableview: self?.tableView ?? UITableView())
                
            }
            
            
        })
    }
    private func fetchData(completion: (()->())? = nil) {
        //        startLoading()
        self.getChallenges(completion: {
            DispatchQueue.main.async {
                
                //                    self.endLoading()
                
            }
        })
    }
    private func getChallenges(completion: @escaping () -> Void) {
        
        
        challengesViewModel.getAllChallenges { (error) in
            if error != nil {
                print(error?.description as Any)
            }
            else {
                // ToDo: stop animation
                self.challenges = self.challengesViewModel.challenges.filter {
                    $0.isReferral ?? false
                }
                
                completion()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    self.tableView.layoutIfNeeded()
                    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
                    self.delegate?.dataReady(tableview: self.tableView)
                    
                }
                
                
            }
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentFeature == Features.LeaderBoard.rawValue {
            return self.leaderboardProfiles.count
        }
        return self.challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentFeature == Features.LeaderBoard.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier:leaderBoardTableViewCell ) as! LeaderBoardTableViewCell
            cell.selectionStyle = .none
            
            if leaderboardProfiles.count > 0 {
                cell.rankNumber = (indexPath.row + 1)
                cell.profile = leaderboardProfiles[indexPath.row]
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: referalFriendTableViewCell) as! ReferalFriendTableViewCell
        cell.selectionStyle = .none
        cell.challenge = challenges[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if currentFeature == Features.LeaderBoard.rawValue {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: leaderBoardHeaderView) as! LeaderBoardHeaderView
            
            return  headerView
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: referalHeaderViewTableView) as! ReferalHeaderViewTableView
        headerView.copyBtn.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        self.sharingCodeText = headerView.textField.text ?? ""
        return  headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if currentFeature == Features.LeaderBoard.rawValue {
            return 94
            
            
        }
        
        return 172
    }
    
    @objc func copyAction(sender: UIButton!) {
        
        print(sharingCodeText)
        
        self.delegate?.shareText(text: sharingCodeText)
    }
    
}
