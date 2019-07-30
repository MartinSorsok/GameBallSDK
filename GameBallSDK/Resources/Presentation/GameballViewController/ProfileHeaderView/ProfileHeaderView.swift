//
//  ProfileHeaderView.swift
//  GameBallDemo
//
//  Created by Omar Ali on 2/1/19.
//  Copyright © 2019 Omar Ali. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var viewModel: PlayerDetailsViewModel = PlayerDetailsViewModel()
    var playerInfoViewModel: PlayerInfoViewModel = PlayerInfoViewModel()
    
    @IBOutlet var view: UIView!{
        didSet {
            view.isHidden = true
        }
    }
    
    @IBOutlet private weak var profileIconImageView: UIImageView!
    @IBOutlet private weak var progressView: ProgressView!
    weak var delegate: ProfileHeaderViewDelegate?
    @IBOutlet weak var youAreOnLevelLabel: UILabel!{
        didSet{
            youAreOnLevelLabel.text = LocalizationsKeys.GameballScreen.youAreOnLevelText.rawValue.localized
            //                    frubiesTitleLabel.textColor = Colors.appGray173
            
            if Localizator.sharedInstance.language == Languages.arabic {
                youAreOnLevelLabel.font = Fonts.cairoRegularFont10
                
            } else {
                youAreOnLevelLabel.font = Fonts.montserratLightFont10
                
            }
        }
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!{
        didSet{
        welcomeLabel.text = LocalizationsKeys.GameballScreen.welcomeText.rawValue.localized
//                    frubiesTitleLabel.textColor = Colors.appGray173
        
        if Localizator.sharedInstance.language == Languages.arabic {
            welcomeLabel.font = Fonts.cairoRegularFont14
            
        } else {
            welcomeLabel.font = Fonts.montserratLightFont14
            
        }
    }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!{
        didSet{
            //                    frubiesTitleLabel.textColor = Colors.appGray173
            
            if Localizator.sharedInstance.language == Languages.arabic {
                userNameLabel.font = Fonts.cairoBoldFont14
                
            } else {
                userNameLabel.font = Fonts.montserratSemiBoldFont14
                
            }
        }
    }
    
    
    @IBOutlet private weak var frubiesTitleLabel: UILabel! {
        didSet {
            frubiesTitleLabel.text = "\(GameballApp.clientBotStyle?.rankPointsName ?? "") "
//            frubiesTitleLabel.textColor = Colors.appGray173
            
            if Localizator.sharedInstance.language == Languages.arabic {
                frubiesTitleLabel.font = Fonts.cairoRegularFont12

            } else {
                frubiesTitleLabel.font = Fonts.montserratLightFont12

            }
        }
    }
    @IBOutlet private weak var frubiesValueLabel: UILabel! {
        didSet {
            
            frubiesValueLabel.textColor = Colors.appGray103
            if Localizator.sharedInstance.language == Languages.arabic {
                frubiesValueLabel.font = Fonts.cairoBoldFont12

            } else {
                frubiesValueLabel.font = Fonts.montserratSemiBoldFont12

            }
        }
    }
    @IBOutlet private weak var pointsTitleLabel: UILabel! {
        didSet {
            pointsTitleLabel.text = "\(GameballApp.clientBotStyle?.walletPointsName ?? "") "
//            pointsTitleLabel.textColor = Colors.appGray173
            
            if Localizator.sharedInstance.language == Languages.arabic {
                pointsTitleLabel.font = Fonts.cairoRegularFont12

            } else {
                pointsTitleLabel.font = Fonts.montserratLightFont12

            }
        }
    }
    @IBOutlet private weak var pointsValueLabel: UILabel! {
        didSet {
            pointsValueLabel.textColor = Colors.appGray103
            if Localizator.sharedInstance.language == Languages.arabic {
                pointsValueLabel.font = Fonts.cairoBoldFont12

            } else {
                pointsValueLabel.font = Fonts.montserratSemiBoldFont12

            }
        }
    }
    @IBOutlet private weak var customerTypeLabel: UILabel! {
        didSet {
//            customerTypeLabel.textColor = Colors.appCustomDarkGray
            
            if Localizator.sharedInstance.language == Languages.arabic {
                customerTypeLabel.font = Fonts.cairoBoldFont16
                
            } else {
                customerTypeLabel.font = Fonts.montserratSemiBoldFont16
                
            }
        }
    }
    @IBOutlet private weak var nextTierTitleLabel: UILabel! {
        didSet {
            nextTierTitleLabel.text = LocalizationsKeys.GameballScreen.nextLevelText.rawValue.localized
//            nextTierTitleLabel.textColor = Colors.appGray173
            if Localizator.sharedInstance.language == Languages.arabic {
                nextTierTitleLabel.font = Fonts.cairoRegularFont10
                
            } else {
                nextTierTitleLabel.font = Fonts.montserratLightFont10
                
            }
        }
    }
    @IBOutlet private weak var nextTierValueLabel: UILabel! {
        didSet {
//            nextTierValueLabel.textColor = Colors.appGray173
            if Localizator.sharedInstance.language == Languages.arabic {
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
    
    private var playerInfo: PlayerInfo? {
        didSet {
            guard let playerInfo = playerInfo else { return }
            DispatchQueue.main.async {
                self.setupView(with: playerInfo)
            }
        }
    }
    
    private var playerNextLevel: Level? {
        didSet {
            guard let playerNextLevel = playerNextLevel else { return }
            if let playerInfo = self.playerInfo {
                if let level = playerInfo.level {
                    DispatchQueue.main.async {
                        self.setupPlayerNextLevel(playerInfo: playerInfo, nextlevel: playerNextLevel)
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
//        progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled: 0.5)
//        setupViews()
        fetchData(completion: {
            self.delegate?.dataReady(view: self.view)
            DispatchQueue.main.async {
                self.view.isHidden = false

            }
            print("done fetchPlayerInfo ")
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
                print("an error occured")
            }
            else {
                // set header view vars
                if let playerInfo = self.playerInfoViewModel.playerInfo {
                    self.playerInfo = playerInfo
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
        
        
        var path = model.level?.icon?.fileName ?? "assets/images/bolt.png"
        path = "/" + path
        NetworkManager.shared().loadImage(path: path) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
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
        
        let path = model.level?.icon?.fileName ?? "https://assets.gameball.co/sample/4.png"
        NetworkManager.shared().loadImage(path: path.replacingOccurrences(of: " ", with: "%20")) { (myImage, error) in
            if let errorModel = error {
                print(errorModel.description)
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

    
    private func setupPlayerNextLevel(playerInfo: PlayerInfo, nextlevel: Level) {
        
        if let currentFrubies = playerInfo.accFrubies, let targetFrubies = nextlevel.levelFrubies {
//            let percentageFilled = Float(currentFrubies) / Float(targetFrubies)
            let percentageFilled = Float(0.8)
            let color = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
            progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: color!, percentageFilled: percentageFilled)
            nextTierValueLabel.text = "\(targetFrubies ?? 0) F"
        }
//        if let currentFrubies = playerDetails?.accFrubies, let targetFrubies = playerNextLevel.levelFrubies {
//            let percentageFilled = Float(currentFrubies) / Float(targetFrubies)
//            let color = UIColor.init(hex: GameballApp.clientBotStyle?.botMainColor ?? "#E7633F")
//            progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: color!, percentageFilled: percentageFilled)
//        }
//        nextTierValueLabel.text = "\(playerNextLevel.levelFrubies ?? 0) F"
    }
    
}
