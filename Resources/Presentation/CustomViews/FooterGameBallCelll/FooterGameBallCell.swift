//
//  FooterGameBallCell.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 5/7/19.
//

import UIKit

class FooterGameBallCell: UITableViewHeaderFooterView {
    
    
    @IBOutlet weak var weRunLabel: UILabel!{
        didSet{
            weRunLabel.text = LocalizationsKeys.General.gameballFooterText.rawValue.localized
            weRunLabel.textColor = Colors.appGray153
            weRunLabel.font = Fonts.appFont14Bold
        }
    }
    
    @IBOutlet weak var gameBallLabel: UILabel!{
    didSet{
            gameBallLabel.text = "Gameball"
            gameBallLabel.textColor = Colors.appGray153
            gameBallLabel.font = Fonts.appFont14Bold
        }
    }

}
