//
//  HeaderCollectionReusableView.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/21/19.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if Localizator.sharedInstance.language == Languages.arabic {
                titleLabel.font = Fonts.cairoBoldFont16

            } else {
                titleLabel.font = Fonts.montserratSemiBoldFont16
            }
            titleLabel.textColor = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
        
        // Customize here
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
        
}
