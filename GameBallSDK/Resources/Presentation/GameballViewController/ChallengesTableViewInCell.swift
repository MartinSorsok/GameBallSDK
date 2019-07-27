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
    
    private var challenges: [Challenge] = []
    weak var delegate:TabBarDelegate?
    private let challengesViewModel = ChallengesViewModel()
    var  currentFeature = 0
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.separatorStyle = .none
            tableView.dataSource = self
            tableView.delegate = self
            tableView.showsVerticalScrollIndicator = false
            tableView.register(UINib(nibName: referalFriendTableViewCell, bundle: nil), forCellReuseIdentifier: referalFriendTableViewCell)
            tableView.register(UINib(nibName: referalHeaderViewTableView, bundle: nil), forHeaderFooterViewReuseIdentifier: referalHeaderViewTableView)
        }
    }
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         fetchData()
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
        
        
        return self.challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: referalFriendTableViewCell) as! ReferalFriendTableViewCell
           cell.challenge = challenges[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: referalHeaderViewTableView) as! ReferalHeaderViewTableView
        
        return  headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 162
    }
    
    
}
