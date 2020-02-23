//
//  ProfileHeaderView.swift
//  GameBallDemo
//
//  Created by Omar Ali on 2/1/19.
//  Copyright © 2019 Omar Ali. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var rankPointsImage: UIImageView!
    @IBOutlet weak var walletPointsImage: UIImageView!
    @IBOutlet weak var greyBarHeightConstant: NSLayoutConstraint!
    var viewModel: PlayerDetailsViewModel = PlayerDetailsViewModel()
    var playerInfoViewModel: PlayerInfoViewModel = PlayerInfoViewModel()
    
    @IBOutlet weak var pointsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var levelViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rankLevelConstraint: NSLayoutConstraint!
    @IBOutlet weak var rankPointsViewConstraint: UIView!
    @IBOutlet weak var mainViewContainer: UIView!{
        didSet {
            mainViewContainer.backgroundColor = Colors.appMainColor
        }
    }
    @IBOutlet weak var nextTireRankPointImage: UIImageView!{
        didSet {
            nextTireRankPointImage.isHidden = true
        }
    }
    @IBOutlet weak var singlePointsView: UIView!{
        didSet {
            
            singlePointsView.layer.cornerRadius = 11
            singlePointsView.layer.masksToBounds = true
            singlePointsView.backgroundColor = Colors.appMainColor ?? .black
            singlePointsView.isHidden = true
        }
    }
    
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var singleViewPointsImage: UIImageView!{
        didSet{
            
        }
    }
    @IBOutlet weak var singleViewPointsValue: UILabel!
    
    @IBOutlet var view: UIView!{
        didSet {
            view.isHidden = true
        }
    }
    
    @IBOutlet weak var topContainerView: UIView!{
        didSet {
            topContainerView.layer.cornerRadius = 6
            topContainerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var pointsViewContainer: UIView!{
        didSet {
            pointsViewContainer.layer.cornerRadius = 6
            pointsViewContainer.clipsToBounds = true
        }
    }
    @IBOutlet private weak var profileIconImageView: UIImageView!
    @IBOutlet private weak var progressView: ProgressView!{
        didSet {
            progressView.isHidden = true
        }
    }
    weak var delegate: ProfileHeaderViewDelegate?
    @IBOutlet weak var youAreOnLevelLabel: UILabel!{
        didSet{
            youAreOnLevelLabel.text = GB_LocalizationsKeys.GameballScreen.youAreOnLevelText.rawValue.localized
            youAreOnLevelLabel.textColor = Colors.appGray128
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                youAreOnLevelLabel.font = Fonts.cairoRegularFont10
                
            } else {
                youAreOnLevelLabel.font = Fonts.montserratLightFont10
                
            }
        }
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!{
        didSet{
            welcomeLabel.text = GB_LocalizationsKeys.GameballScreen.welcomeText.rawValue.localized
            //                    frubiesTitleLabel.textColor = Colors.appGray173
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                welcomeLabel.font = Fonts.cairoRegularFont14
                
            } else {
                welcomeLabel.font = Fonts.montserratLightFont14
                
            }
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!{
        didSet{
            //                    frubiesTitleLabel.textColor = Colors.appGray173
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                userNameLabel.font = Fonts.cairoBoldFont14
                
            } else {
                userNameLabel.font = Fonts.montserratSemiBoldFont14
                
            }
        }
    }
    
    
    @IBOutlet private weak var frubiesTitleLabel: UILabel! {
        didSet {
            frubiesTitleLabel.textColor = .black
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                frubiesTitleLabel.font = Fonts.cairoBoldFont12
            } else {
                frubiesTitleLabel.font = Fonts.montserratSemiBoldFont12
            }
        }
    }
    @IBOutlet private weak var frubiesValueLabel: UILabel! {
        didSet {
            
            frubiesValueLabel.textColor = .black
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                frubiesValueLabel.font = Fonts.cairoRegularFont28
                
            } else {
                frubiesValueLabel.font = Fonts.montserratLightFont28
            }
        }
    }
    @IBOutlet private weak var pointsTitleLabel: UILabel! {
        didSet {
            pointsTitleLabel.textColor = .black
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                pointsTitleLabel.font = Fonts.cairoBoldFont12
            } else {
                pointsTitleLabel.font = Fonts.montserratSemiBoldFont12
            }
        }
    }
    @IBOutlet weak var pointsHint: UILabel!{
        didSet {
            pointsHint.textColor = Colors.appGray128
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                pointsHint.font = Fonts.cairoRegularFont10
            } else {
                pointsHint.font = Fonts.montserratLightFont10
            }
        }
    }
    @IBOutlet private weak var pointsValueLabel: UILabel! {
        didSet {
            pointsValueLabel.textColor = .black
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                pointsValueLabel.font = Fonts.cairoRegularFont28
                
            } else {
                pointsValueLabel.font = Fonts.montserratLightFont28
                
            }
        }
    }
    @IBOutlet private weak var customerTypeLabel: UILabel! {
        didSet {
            customerTypeLabel.textColor = Colors.appBlack26
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                customerTypeLabel.font = Fonts.cairoBoldFont16
                
            } else {
                customerTypeLabel.font = Fonts.montserratSemiBoldFont16
                
            }
        }
    }
    @IBOutlet private weak var nextTierTitleLabel: UILabel! {
        didSet {
            
            nextTierTitleLabel.isHidden = true
            nextTierTitleLabel.text = GB_LocalizationsKeys.GameballScreen.nextLevelText.rawValue.localized
            //            nextTierTitleLabel.textColor = Colors.appGray173
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                nextTierTitleLabel.font = Fonts.cairoRegularFont10
                
            } else {
                nextTierTitleLabel.font = Fonts.montserratLightFont10
                
            }
        }
    }
    @IBOutlet private weak var nextTierValueLabel: UILabel! {
        didSet {
            //            nextTierValueLabel.textColor = Colors.appGray173
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                nextTierValueLabel.font = Fonts.cairoRegularFont12
                
            } else {
                nextTierValueLabel.font = Fonts.montserratLightFont12
                
            }
        }
    }
    
    
    
    
    private var playerDetails: PlayerDetails? {
        didSet {
            guard let playerDetails = playerDetails else { return }
            DispatchQueue.main.async {
                [weak self] in
                self?.setupView(with: playerDetails)
            }
        }
    }
    
    
    //    private var playerNextLevel: PlayerNextLevel? {
    //        didSet {
    //            guard let playerNextLevel = playerNextLevel else { return }
    //            DispatchQueue.main.async {
    //                self.setupPlayerNextLevel(with: playerNextLevel)
    //            }
    //        }
    //    }
    
    private var playerAttributes: PlayerInfo? {
        didSet {
            guard let playerAttributes = playerAttributes else { return }
            DispatchQueue.main.async {
                self.setupView(with: playerAttributes)
            }
        }
    }
    
    private var playerNextLevel: Level? {
        didSet {
            guard let playerNextLevel = playerNextLevel else { return }
            if let playerAttributes = self.playerAttributes {
                if let level = playerAttributes.level {
                    DispatchQueue.main.async {
                        self.setupPlayerNextLevel(playerAttributes: playerAttributes, nextlevel: playerNextLevel)
                    }
                }
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.init(for: type(of: self)).loadNibNamed("ProfileHeaderView", owner: self, options: nil)
        self.addSubview(self.view);
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        commonInit()
    }
    
    private func commonInit() {
        //        setupViews()
        
        frubiesTitleLabel.text = "\(GameballApp.clientBotStyle?.rankPointsName ?? "") "
        pointsTitleLabel.text = "\(GameballApp.clientBotStyle?.walletPointsName ?? "") "
        
        if GameballApp.clientBotStyle?.isRankPointsVisible ?? false && GameballApp.clientBotStyle?.isWalletPointsVisible ?? false {
            singlePointsView.isHidden = true
            sepratorView.isHidden = false
  
            
        } else {
            if !(GameballApp.clientBotStyle?.isRankPointsVisible ?? false) {
                rankPointsViewConstraint.isHidden = true
                levelViewHeightConstraint.constant = 0
            }
            if  !(GameballApp.clientBotStyle?.isWalletPointsVisible ?? false)  {
                pointsViewContainer.isHidden = true
                pointsHeightConstraint.constant = 0
            }
        }
        
        
        fetchData(completion: {
            self.delegate?.dataReady(view: self.view)
            DispatchQueue.main.async {
                self.view.isHidden = false
                
            }
            Helpers().dPrint("done fetchPlayerInfo ")
        })
    }
    
    func fetchData(completion: @escaping () -> Void) {
        
        //        fetchPlayerDetails(completion: completion)
        fetchPlayerInfo(completion: completion)
        
    }
    
    private func fetchPlayerInfo(completion: @escaping () -> Void) {
        self.playerInfoViewModel.getPlayerInfo { (error) in
            if error != nil {
                // ToDo: Show message to user
                Helpers().dPrint("an error occured")
            }
            else {
                // set header view vars
                if let playerAttributes = self.playerInfoViewModel.playerAttributes {
                    self.playerAttributes = playerAttributes
                }
                if let nextLevel = self.playerInfoViewModel.nextLevel {
                    self.playerNextLevel = nextLevel
                }
            }
            completion()
        }
    }
    
    //    private func fetchPlayerDetails(completion: @escaping () -> Void) {
    //        // ToDo: show loading animation
    //        self.viewModel.getPlayerDetails {
    //            [weak self] error in
    //            if error != nil {
    //                // ToDo: Show message to user
    //            }
    //            else {
    //                if let model = self?.viewModel.playerDetails {
    //                    self?.playerDetails = model
    //                }
    //                self?.fetchNextLevel(completion: completion)
    //            }
    //            // ToDo: hide loading animation
    //        }
    //    }
    
    //    private func fetchNextLevel(completion: @escaping () -> Void) {
    //        let playerNextLevelViewModel = PlayerNextLevelViewModel()
    //        playerNextLevelViewModel.getLeaderboard(completion: {
    //            [weak self] error in
    //            if error != nil {
    //                // handle error
    //                return
    //            }
    //
    //            self?.playerNextLevel = playerNextLevelViewModel.playerNextLevel
    //            completion()
    //
    //
    //        })
    //    }
    
    
    private func setupView(with model: PlayerDetails) {
        
        let frubiesValue = model.accFrubies ?? 0
        frubiesValueLabel.text = String(frubiesValue)
        
        let pointsValue = model.accPoints ?? 0
        pointsValueLabel.text = String(pointsValue)
        customerTypeLabel.text = model.name ?? "Player"
        
        if GameballApp.clientBotStyle?.isRankPointsVisible ?? false {
            singleViewPointsValue.text = String(frubiesValue)
        } else {
            singleViewPointsValue.text = String(pointsValue)
        }
        
        var path = model.level?.icon?.fileName ?? "assets/images/bolt.png"
        path = "/" + path
        NetworkManager.shared().loadImage(path: path) { (myImage, error) in
            if let errorModel = error {
                Helpers().dPrint(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.profileIconImageView.image = result
                    self.profileIconImageView.alpha = 0
                    UIView.animate(withDuration: 1.0, animations: {
                        self.profileIconImageView.alpha = 1.0
                    })
                }
            }
        }
    }
    
    private func setupView(with model: PlayerInfo) {
        
        let frubiesValue = model.accFrubies ?? 0
        frubiesValueLabel.text = String(frubiesValue)
        
        let pointsValue = model.accPoints ?? 0
        pointsValueLabel.text = String(pointsValue)
        //        let firstName = model.firstName ?? "Gameball Player"
        //        let lastName = model.lastName ?? ""
        //        let name = firstName + lastName
        userNameLabel.text = model.displayName ?? "Gameball Player"
        customerTypeLabel.text = model.level?.name
        pointsHint.text = "Equals to \(String(pointsValue)) USD"
        
        if GameballApp.clientBotStyle?.isRankPointsVisible ?? false {
            singleViewPointsValue.text = String(frubiesValue)
        } else {
            singleViewPointsValue.text = String(pointsValue)
        }
        let path = model.level?.icon?.fileName ?? "https://assets.gameball.co/sample/4.png"
        NetworkManager.shared().loadImage(path: path.replacingOccurrences(of: " ", with: "%20")) { (myImage, error) in
            if let errorModel = error {
                Helpers().dPrint(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.profileIconImageView.image = result
                    self.profileIconImageView.alpha = 0
                    UIView.animate(withDuration: 1.0, animations: {
                        self.profileIconImageView.alpha = 1.0
                    })
                }
            }
        }
    }
    
    
    private func setupPlayerNextLevel(playerAttributes: PlayerInfo, nextlevel: Level) {
        
        if let currentFrubies = playerAttributes.accFrubies, let targetFrubies = nextlevel.levelFrubies {
            nextTierTitleLabel.isHidden = false
            nextTireRankPointImage.isHidden = false
            progressView.isHidden = false
            
            let percentageFilled = Float(currentFrubies) / Float(targetFrubies)
            //            let percentageFilled = Float(0.8)
            let color = Colors.progressMainColor
            progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: color, percentageFilled: percentageFilled)
            nextTierValueLabel.text = "\(targetFrubies)"
        }
        //        if let currentFrubies = playerDetails?.accFrubies, let targetFrubies = playerNextLevel.levelFrubies {
        //            let percentageFilled = Float(currentFrubies) / Float(targetFrubies)
        //            let color = UIColor.init(hex: GameballApp.clientBotStyle?.botMainColor ?? "#E7633F")
        //            progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: color!, percentageFilled: percentageFilled)
        //        }
        //        nextTierValueLabel.text = "\(playerNextLevel.levelFrubies ?? 0) F"
    }
    
}
