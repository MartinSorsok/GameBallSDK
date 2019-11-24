//
//  LeaderBoardHeaderView.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/27/19.
//

import UIKit

class LeaderBoardHeaderView: UITableViewHeaderFooterView {


    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
             titleLabel.text =  GB_LocalizationsKeys.LeaderBoardScreen.leaderboardTitle.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                titleLabel.font = Fonts.cairoBoldFont16
                
            } else {
                titleLabel.font = Fonts.montserratSemiBoldFont16
            }
            titleLabel.textColor = Colors.appMainColor ?? .black
        }
    }
    
    @IBOutlet weak var yourRankLabel: UILabel!{
        didSet {
             yourRankLabel.text =  GB_LocalizationsKeys.LeaderBoardScreen.yourRank.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                yourRankLabel.font = Fonts.cairoRegularFont12
                
            } else {
                yourRankLabel.font = Fonts.montserratLightFont12
            }
            yourRankLabel.textColor = .black
        }
    }
    
    
    @IBOutlet weak var yourRankValue: UILabel!{
        didSet {
            // titleLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                yourRankValue.font = Fonts.cairoBoldFont12
                
            } else {
                yourRankValue.font = Fonts.montserratSemiBoldFont12
            }
            yourRankValue.textColor = .black
        }
    }
    
    @IBOutlet weak var filterByLabel: UILabel!{
        didSet {
            // titleLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                filterByLabel.font = Fonts.cairoBoldFont12
                
            } else {
                filterByLabel.font = Fonts.montserratSemiBoldFont12
            }
            filterByLabel.textColor = .black
        }
    }

    
}
