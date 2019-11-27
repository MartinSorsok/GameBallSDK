//
//  ChallengeDetailsViewController.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/31/19.
//

import UIKit

class ChallengeDetailsViewController: BaseViewController {

    var isTypeEmbed = false
    
    
    @IBOutlet weak var closeButton: UIButton!
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
    private var challengeDetailsHeaderCell = "ChallengeDetailsHeaderCell"
    private var highScoreTableViewCell = "HighScoreTableViewCell"
    private var progressBarTableViewCell = "ProgressBarTableViewCell"
    private var statusTableViewCell = "StatusTableViewCell"
    
    @IBOutlet weak var mainTableView: UITableView!
    

    @IBOutlet weak var backBtn: UIButton!{
        didSet {
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                self.backBtn.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
        }
    }
    
    var challenge: Challenge? {
        didSet {
            //mainTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }

    func setupUI() {

        self.navigationController?.navigationBar.isHidden = true
        if isTypeEmbed {
            closeButton.isHidden = true
        } else {
            closeButton.isHidden = false
        }
    }
    
    func setupTableView() {
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 600
        mainTableView.tableFooterView = UIView()
        
        mainTableView.register(UINib(nibName: challengeDetailsHeaderCell, bundle: nil), forCellReuseIdentifier: challengeDetailsHeaderCell)
        mainTableView.register(UINib(nibName: highScoreTableViewCell, bundle: nil), forCellReuseIdentifier: highScoreTableViewCell)
        mainTableView.register(UINib(nibName: progressBarTableViewCell, bundle: nil), forCellReuseIdentifier: progressBarTableViewCell)
        mainTableView.register(UINib(nibName: statusTableViewCell, bundle: nil), forCellReuseIdentifier: statusTableViewCell)
        
    }

    @IBAction func closeBtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ChallengeDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (!(self.challenge?.completionPercentage?.isLess(than: 1.0) ?? true) && (self.challenge?.isActive ?? false)) || self.challenge?.highScoreAmount ?? 0 > 0 {
            return 3
        } else {
            return 2
        }


    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: challengeDetailsHeaderCell) as! ChallengeDetailsHeaderCell
            cell.challenge = self.challenge
            return cell
        } else if indexPath.row == 1 && (self.challenge?.challengeType ?? .unkown == .EventBased || self.challenge?.challengeType ?? .unkown == .FriendReferal ) && !(self.challenge?.completionPercentage?.isLess(than: 1.0) ?? true) && (self.challenge?.isActive ?? false)  {
            let cell = tableView.dequeueReusableCell(withIdentifier: progressBarTableViewCell) as! ProgressBarTableViewCell
            cell.challenge = self.challenge
            return cell
            
        } else if indexPath.row == 1 && self.challenge?.challengeType ?? .unkown == .Highscore && self.challenge?.highScoreAmount ?? 0 > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: highScoreTableViewCell) as! HighScoreTableViewCell
            cell.challenge = self.challenge
            return cell
        }
        
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: statusTableViewCell) as! StatusTableViewCell
            cell.challenge = self.challenge
            return cell
            
        }
        
    }
    
    
    
}


extension ChallengeDetailsViewController: UITableViewDelegate {
    
    
}
