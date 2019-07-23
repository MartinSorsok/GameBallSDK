//
//  AchievementDetailsViewController.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/8/19.
//  Copyright Â© 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class AchievementDetailsViewController: BaseViewController {
    
    let milestoneCellReuseIdentifier = "MilestoneTableViewCell"
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appGray239
        return view
    }()
    
    private let progressContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.backgroundColor = Colors.appOrange
        return view
    }()
    
    private var progessViewHeightConstraint: NSLayoutConstraint?
    
    private let curvedView: UIView = {
        let view = CurvedView(color: Colors.appGray239)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionOfBackButton), for: .touchUpInside)
        button.setImage(UIImage(named: "BackArrow3", in:  Bundle.init(for: type(of: self)), compatibleWith: nil), for: [])
        return button
    }()
    
    private let achievementImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "award"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
//    private let lockView: UIView = {
//        let iv = LockView(lockSize: .large)
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.clipsToBounds = true
//        iv.contentMode = .scaleAspectFit
//        iv.isHidden = true
//        return iv
//    }()
    
    private let achievementTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray74
        label.font = Fonts.appFont20Bold
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let achievementDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray130
        label.font = Fonts.appFont16Regular
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let highscoreTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appOrange
        label.font = Fonts.appFont16Regular
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "High Score"
        return label
    }()
    
    private let highscoreDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray130
        label.font = Fonts.appFont24Regular
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    private let achievmentProgressUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appOrange
        label.font = Fonts.appFont16Regular
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Progress"
        return label
    }()
    
    private let achievmentProgressActionUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray103
        label.font = Fonts.appFont12
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "10"
        return label
    }()
    
    private let achievmentProgressActionDetailsUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray103
        label.font = Fonts.appFont12
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Only 2 like(s) remainging to achieve this challenge"
        return label
    }()
    
    private let achievmentProgressAmountUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray103
        label.font = Fonts.appFont12
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "10"
        return label
    }()
    
    private let achievmentProgressAmountDetailsUILabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray103
        label.font = Fonts.appFont12
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Only 6678 EGP remainging to achieve this challenge"
        return label
    }()
    
    
    
    private let achievemntActionsCompletedProgressBar: ProgressView = {
        let progressBar = ProgressView(frame: CGRect(x: 0, y: 0, width: 300, height: 6))
        //        let progressBar = ProgressView()
        //        progressBar.translatesAutoresizingMaskIntoConstraints = false
        //        progressBar.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: 50)
        return progressBar
    }()
    
    private let achievemntAmountCompletedProgressBar: ProgressView = {
        let progressBar = ProgressView(frame: CGRect(x: 0, y: 0, width: 300, height: 6))
        //        progressBar.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: 90)
        return progressBar
    }()
    
    
    
    private let achievementStatusImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "award"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let achievementStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.appGray130
        label.font = Fonts.appFont16Regular
        label.textAlignment = .center
        label.text = "Keep Going ,earn this badge and claim your prize"
        label.numberOfLines = 0
        return label
    }()
    
    let labelTwo: UILabel = {
        let label = UILabel()
        label.text = "Scroll Bottom"
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private var tableView: UITableView?
    
    let challenge: Challenge
    
    private var offset: CGFloat = 70
    private let padding: CGFloat = 40
    
    
    init(challenge: Challenge) {
        self.challenge = challenge
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.clipsToBounds = true
        addSubViews()
        addConstraints()
        // conifgure the three methods based on different view types (4)
//        switch challenge.challengeType {
//        case .ActionAndAmountBased:
//            amountAndActionBasedPage()
//            break
//        case .ActionBased:
//            actionBasedPage()
//            break
//        case .AmountBased:
//            amountBasedPage()
//            break
//        case .Highscore:
//            highScorePage()
//            break
//        default:
//            print("The challenge has not type!!!")
//        }
        addMilestonesView()
        setupProperties(with: challenge)
        
    }
    
    
    private func addSubViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topContainerView)
        
        
        // Top Container Subviews
        topContainerView.addSubview(curvedView)
        topContainerView.addSubview(backButton)
        topContainerView.addSubview(achievementImageView)
//        topContainerView.addSubview(lockView)
        topContainerView.addSubview(achievementTitleLabel)
        topContainerView.addSubview(achievementDescriptionLabel)
        
    }
    
    private func addTableView() {
        let tableView = UITableView()
        tableView.register(MilestoneTableViewCell.self, forCellReuseIdentifier: milestoneCellReuseIdentifier)
//        tableView.delegate = self as? UITableViewDelegate
        self.tableView = tableView
        
    }
    
    private func addAchievmentSectionViews() {
        // Achievement Image
        contentView.addSubview(achievementStatusImageView)
        contentView.addSubview(achievementStatusLabel)
        
    }
    
    private func addAchievementSectionConstraints() {
        
        // Achievement Image View
        
        achievementStatusImageView.topAnchor.constraint(equalTo: progressContainerView.bottomAnchor, constant: 60).isActive = true
        achievementStatusImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        achievementStatusImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        achievementStatusImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        achievementStatusLabel.topAnchor.constraint(equalTo: achievementStatusImageView.bottomAnchor, constant: 15).isActive = true
        achievementStatusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        achievementStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        
        achievementStatusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true

    }
    
    private func highScorePage() {
        
    }
    
    private func addHighScorePageViews() {
        
    }
    
    private func addHighScorePageConstraints() {
        
    }
    
    private func addMilestonesView() {
        addTableView()
        
//        if let myTable = self.tableView {
//            progressContainerView.addSubview(myTable)
//            myTable.dataSource = self
//            myTable.reloadData()
//        }
        contentView.addSubview(progressContainerView)
//        progressContainerView.addSubview(self.tableView!)
//        self.tableView!.dataSource = self
//        self.tableView!.reloadData()
        
        addMilestonesConstraints()
        addAchievmentSectionViews()
        addAchievementSectionConstraints()
        
    }
    
    private func addMilestonesConstraints() {
        progressContainerView.topAnchor.constraint(equalTo: curvedView.bottomAnchor, constant: 20).isActive = true
        progressContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        progressContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        progessViewHeightConstraint = progressContainerView.heightAnchor.constraint(equalToConstant: 400)
        progressContainerView.backgroundColor = UIColor.green
//        progessViewHeightConstraint?.isActive = true
//        progressContainerView.bottomAnchor.constraint(equalTo: tableView!.bottomAnchor).isActive = true
//        tableView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        tableView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        tableView!.topAnchor.constraint(equalTo: progressContainerView.topAnchor, constant: 20).isActive = true
//        tableView!.centerXAnchor.constraint(equalToSystemSpacingAfter: contentView.centerXAnchor, multiplier: 1).isActive = true
//        tableView!.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
//        tableView!.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
//        tableView?.heightAnchor.constraint(equalToConstant: 300)

    }
    
    private func actionBasedPage() {
        addActionBasedViews()
        addActionBasedConstraints()
        addAchievmentSectionViews()
        addAchievementSectionConstraints()
    }
    
    private func addActionBasedViews() {
        // Progress View
        contentView.addSubview(progressContainerView)
        progressContainerView.addSubview(achievmentProgressUILabel)
        progressContainerView.addSubview(achievemntActionsCompletedProgressBar)
        progressContainerView.addSubview(achievmentProgressActionUILabel)
        progressContainerView.addSubview(achievmentProgressActionDetailsUILabel)
    }
    
    private func addActionBasedConstraints() {
        
        progressContainerView.topAnchor.constraint(equalTo: curvedView.bottomAnchor, constant: 20).isActive = true
        progressContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        progressContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        progessViewHeightConstraint = progressContainerView.heightAnchor.constraint(equalToConstant: 170)
        progessViewHeightConstraint?.isActive = true
        
        
        achievmentProgressUILabel.topAnchor.constraint(equalTo: progressContainerView.topAnchor, constant: 20).isActive = true
        achievmentProgressUILabel.leadingAnchor.constraint(equalTo: achievementDescriptionLabel.leadingAnchor, constant: 0).isActive = true
        achievmentProgressUILabel.heightAnchor.constraint(equalToConstant: 20)
        
        
        
        let screenWidth = UIScreen.main.bounds.width
//        let padding: CGFloat = 40
        achievemntActionsCompletedProgressBar.frame = CGRect(x: self.padding, y: self.offset, width: screenWidth - (padding * 2), height: 6)
        self.offset += 100
        achievmentProgressActionUILabel.trailingAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
        achievmentProgressActionUILabel.bottomAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.topAnchor, constant: -5).isActive = true
        
        achievmentProgressActionDetailsUILabel.topAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.bottomAnchor, constant: 8).isActive = true
        achievmentProgressActionDetailsUILabel.leadingAnchor.constraint(equalTo: achievmentProgressUILabel.leadingAnchor, constant: 0).isActive = true
    }
    
    private func amountBasedPage() {
        addAmountBasedViews()
        addAmountBasedConstraints()
        addAchievmentSectionViews()
        addAchievementSectionConstraints()
    }
    
    private func addAmountBasedViews() {
        
        // Progress View
        contentView.addSubview(progressContainerView)
        progressContainerView.addSubview(achievmentProgressUILabel)
        progressContainerView.addSubview(achievemntAmountCompletedProgressBar)
        progressContainerView.addSubview(achievmentProgressAmountUILabel)
        progressContainerView.addSubview(achievmentProgressAmountDetailsUILabel)
    }
    
    private func addAmountBasedConstraints() {
        
        progressContainerView.topAnchor.constraint(equalTo: curvedView.bottomAnchor, constant: 20).isActive = true
        progressContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        progressContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        progessViewHeightConstraint = progressContainerView.heightAnchor.constraint(equalToConstant: 170)
        progessViewHeightConstraint?.isActive = true
        
        
        achievmentProgressUILabel.topAnchor.constraint(equalTo: progressContainerView.topAnchor, constant: 20).isActive = true
        achievmentProgressUILabel.leadingAnchor.constraint(equalTo: achievementDescriptionLabel.leadingAnchor, constant: 0).isActive = true
        achievmentProgressUILabel.heightAnchor.constraint(equalToConstant: 20)
        
        
        
        let screenWidth = UIScreen.main.bounds.width
//        let padding: CGFloat = 40
 
        
        achievemntAmountCompletedProgressBar.frame = CGRect(x: self.padding, y: self.offset, width: screenWidth - (padding * 2), height: 6)
        //
        achievmentProgressAmountUILabel.trailingAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
        achievmentProgressAmountUILabel.bottomAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.topAnchor, constant: -5).isActive = true
        
        achievmentProgressAmountDetailsUILabel.topAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.bottomAnchor, constant: 8).isActive = true
        achievmentProgressAmountDetailsUILabel.leadingAnchor.constraint(equalTo: achievmentProgressAmountDetailsUILabel.leadingAnchor, constant: 0).isActive = true
        achievmentProgressAmountDetailsUILabel.trailingAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
    }
    
    private func amountAndActionBasedPage() {
        addAmountAndActionBasedViews()
        addAmountAndActionBasedConstraints()
        addAchievmentSectionViews()
        addAchievementSectionConstraints()
    }
    
    private func addAmountAndActionBasedViews() {
        // Progress View
        contentView.addSubview(progressContainerView)
        progressContainerView.addSubview(achievmentProgressUILabel)
        progressContainerView.addSubview(achievemntActionsCompletedProgressBar)
        progressContainerView.addSubview(achievmentProgressActionUILabel)
        progressContainerView.addSubview(achievmentProgressActionDetailsUILabel)
        progressContainerView.addSubview(achievemntAmountCompletedProgressBar)
        progressContainerView.addSubview(achievmentProgressAmountUILabel)
        progressContainerView.addSubview(achievmentProgressAmountDetailsUILabel)
    }
    
    private func addAmountAndActionBasedConstraints() {
        
        
        progressContainerView.topAnchor.constraint(equalTo: curvedView.bottomAnchor, constant: 20).isActive = true
        progressContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        progressContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        progessViewHeightConstraint = progressContainerView.heightAnchor.constraint(equalToConstant: 170)
        progessViewHeightConstraint?.isActive = true
        
        
        achievmentProgressUILabel.topAnchor.constraint(equalTo: progressContainerView.topAnchor, constant: 20).isActive = true
        achievmentProgressUILabel.leadingAnchor.constraint(equalTo: achievementDescriptionLabel.leadingAnchor, constant: 0).isActive = true
        achievmentProgressUILabel.heightAnchor.constraint(equalToConstant: 20)
        
        
        
        let screenWidth = UIScreen.main.bounds.width
        let padding: CGFloat = 40
        achievemntActionsCompletedProgressBar.frame = CGRect(x: padding, y: 70, width: screenWidth - (padding * 2), height: 6)
        //
        //
        //
        //
        achievmentProgressActionUILabel.trailingAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
        achievmentProgressActionUILabel.bottomAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.topAnchor, constant: -5).isActive = true
        
        achievmentProgressActionDetailsUILabel.topAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.bottomAnchor, constant: 8).isActive = true
        achievmentProgressActionDetailsUILabel.leadingAnchor.constraint(equalTo: achievmentProgressUILabel.leadingAnchor, constant: 0).isActive = true
        //
        //
        //
        achievemntAmountCompletedProgressBar.frame = CGRect(x: padding, y: 160, width: screenWidth - (padding * 2), height: 6)
        //
        achievmentProgressAmountUILabel.trailingAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
        achievmentProgressAmountUILabel.bottomAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.topAnchor, constant: -5).isActive = true
        
        achievmentProgressAmountDetailsUILabel.topAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.bottomAnchor, constant: 8).isActive = true
        achievmentProgressAmountDetailsUILabel.leadingAnchor.constraint(equalTo: achievmentProgressActionDetailsUILabel.leadingAnchor, constant: 0).isActive = true
        achievmentProgressAmountDetailsUILabel.trailingAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
        

    }

    
    
    private func addConstraints() {
        
        
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalTo: contentView.superview!.widthAnchor, multiplier: 1.0).isActive = true
        
        
        // Top Container Constraints
        topContainerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        // Top Container Subviews and their constraints
        ///////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////
        let height: CGFloat = 100
        curvedView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: -20).isActive = true
        curvedView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: 20).isActive = true
        curvedView.heightAnchor.constraint(equalToConstant: height).isActive = true
        curvedView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: height / 2).isActive = true
        
        backButton.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 30).isActive = true
        
        achievementImageView.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 60).isActive = true
        achievementImageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        achievementImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        achievementImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
//        lockView.topAnchor.constraint(equalTo: achievementImageView.topAnchor).isActive = true
//        lockView.trailingAnchor.constraint(equalTo: achievementImageView.trailingAnchor).isActive = true
//        lockView.heightAnchor.constraint(equalToConstant: 32).isActive = true
//        lockView.widthAnchor.constraint(equalToConstant: 32).isActive = true
//
//
        achievementTitleLabel.topAnchor.constraint(equalTo: achievementImageView.bottomAnchor, constant: 10).isActive = true
        achievementTitleLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 30).isActive = true
        achievementTitleLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -30).isActive = true
        
        achievementDescriptionLabel.topAnchor.constraint(equalTo: achievementTitleLabel.bottomAnchor, constant: 10).isActive = true
        achievementDescriptionLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor, constant: 10).isActive = true
        achievementDescriptionLabel.trailingAnchor.constraint(equalTo: achievementTitleLabel.trailingAnchor, constant: -30).isActive = true
        
        ///////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////
        
//
//
//
//        progressContainerView.topAnchor.constraint(equalTo: curvedView.bottomAnchor, constant: 20).isActive = true
//        progressContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        progressContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        progessViewHeightConstraint = progressContainerView.heightAnchor.constraint(equalToConstant: 170)
//        progessViewHeightConstraint?.isActive = true
//
//
//        achievmentProgressUILabel.topAnchor.constraint(equalTo: progressContainerView.topAnchor, constant: 20).isActive = true
//        achievmentProgressUILabel.leadingAnchor.constraint(equalTo: achievementDescriptionLabel.leadingAnchor, constant: 0).isActive = true
//        achievmentProgressUILabel.heightAnchor.constraint(equalToConstant: 20)
//
//
//
//        let screenWidth = UIScreen.main.bounds.width
//        let padding: CGFloat = 40
//        achievemntActionsCompletedProgressBar.frame = CGRect(x: padding, y: 70, width: screenWidth - (padding * 2), height: 6)
////
////
////
////
//        achievmentProgressActionUILabel.trailingAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
//        achievmentProgressActionUILabel.bottomAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.topAnchor, constant: -5).isActive = true
//
//        achievmentProgressActionDetailsUILabel.topAnchor.constraint(equalTo: achievemntActionsCompletedProgressBar.bottomAnchor, constant: 8).isActive = true
//        achievmentProgressActionDetailsUILabel.leadingAnchor.constraint(equalTo: achievmentProgressUILabel.leadingAnchor, constant: 0).isActive = true
////
////
////
//        achievemntAmountCompletedProgressBar.frame = CGRect(x: padding, y: 160, width: screenWidth - (padding * 2), height: 6)
////
//        achievmentProgressAmountUILabel.trailingAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
//        achievmentProgressAmountUILabel.bottomAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.topAnchor, constant: -5).isActive = true
//
//        achievmentProgressAmountDetailsUILabel.topAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.bottomAnchor, constant: 8).isActive = true
//        achievmentProgressAmountDetailsUILabel.leadingAnchor.constraint(equalTo: achievmentProgressActionDetailsUILabel.leadingAnchor, constant: 0).isActive = true
//        achievmentProgressAmountDetailsUILabel.trailingAnchor.constraint(equalTo: achievemntAmountCompletedProgressBar.trailingAnchor, constant: 0).isActive = true
//
//
//
//        // Achievement Image View
//
//        achievementStatusImageView.topAnchor.constraint(equalTo: progressContainerView.bottomAnchor, constant: 60).isActive = true
//        achievementStatusImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        achievementStatusImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        achievementStatusImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
//
//        achievementStatusLabel.topAnchor.constraint(equalTo: achievementStatusImageView.bottomAnchor, constant: 15).isActive = true
//        achievementStatusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
//        achievementStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
//
//        achievementStatusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
//
        
    }
    
    
    
    private func setupProperties(with challenge: Challenge) {
        achievementTitleLabel.text = challenge.gameName
        achievementDescriptionLabel.text = challenge.description
//        lockView.isHidden = challenge.isUnlocked ?? false
//        if !lockView.isHidden {
//            lockView.alpha = 0
//            UIView.animate(withDuration: 1) {
//                self.lockView.alpha = 1.0
//            }
//        }
        setChallengeImage(from: challenge)

        switch challenge.status {
        case .locked:
            achievementStatusImageView.image = UIImage.image(named: "ChallengeLockedImage")
        case .inProgress:
            achievementStatusImageView.image = UIImage.image(named: "ChallengeInProgressImage")
        case .achieved:
            achievementStatusImageView.image = UIImage.image(named: "ChallengeAchievedImage")
        }
        
        achievementStatusImageView.alpha = 0
        UIView.animate(withDuration: 1.0) {
            self.achievementStatusImageView.alpha = 1.0
        }
        achievementStatusLabel.text = challenge.statusDescription

        
        
        // maniuplate view based on state
        
        
        
        
        if challenge.status == .inProgress || challenge.status == .achieved {
            
            
            switch challenge.challengeType {
            case .ActionAndAmountBased:
                setActionBasedData()
                setAmountBasedData()
                break
            case .ActionBased:
                setActionBasedData()
                break
            case .AmountBased:
                setAmountBasedData()
                break
            case .Highscore:
                setHighscoreData()
                break
            default:
                break
            }
        }
        else {
            progessViewHeightConstraint?.constant = 0
            self.progressContainerView.isHidden = true
            self.view.layoutIfNeeded()
        }
        
        
        
    }
    
    func setActionBasedData() {
        if challenge.actionsCompletedPercentage != nil {
            DispatchQueue.main.async {
                self.achievemntActionsCompletedProgressBar.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: Float((self.challenge.actionsCompletedPercentage ?? 0)/100.0))
            }
        }
    }
    
    
    func setAmountBasedData() {
        if challenge.amountCompletedPercentage != nil {
            DispatchQueue.main.async {
                self.achievemntAmountCompletedProgressBar.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled:Float((self.challenge.amountCompletedPercentage ?? 0)/100.0))
            }
        }
    }
    
    
    func setHighscoreData() {
        DispatchQueue.main.async {
            let text = self.challenge.highScoreAmount ?? "No Value"
            self.highscoreDescriptionLabel.text = text
        }
    }
    
    
    func setChallengeImage(from model: Challenge) {
        var path = model.icon ?? "assets/images/bolt.png"
        NetworkManager.shared().loadImage(path: path) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                
                DispatchQueue.main.async {
                    self.achievementImageView.image = result
                    self.achievementImageView.alpha = 0
                    UIView.animate(withDuration: 1.0, animations: {
                        self.achievementImageView.alpha = 1.0
                    })
                }
            }
        }
    }
    
    
    @objc private func actionOfBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension AchievementDetailsViewController: UITabBarDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: milestoneCellReuseIdentifier, for: indexPath) as! MilestoneTableViewCell
        return cell
    }
    
}



class CurvedView: UIView {
    
    
    private var path: UIBezierPath!
    private let color: UIColor
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
        backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.color = Colors.curvedViewColor
        super.init(coder: aDecoder)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func draw(_ rect: CGRect) {
        self.path = UIBezierPath(ovalIn: self.bounds)
        color.setFill()
        path.fill()
    }
    
}
