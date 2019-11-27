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
      
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                titleLabel.font = Fonts.cairoBoldFont16

            } else {
                titleLabel.font = Fonts.montserratSemiBoldFont16
            }
            titleLabel.textColor = Colors.appMainColor ?? .black
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet {
      
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                descriptionLabel.font = Fonts.cairoRegularFont14

            } else {
                descriptionLabel.font = Fonts.montserratLightFont14
            }
            descriptionLabel.textColor = .black
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
