//
//  ReferalHeaderViewCollectionReusableView.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 7/26/19.
//

import UIKit

class ReferalHeaderViewTableView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
           // titleLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if Localizator.sharedInstance.language == Languages.arabic {
                titleLabel.font = Fonts.cairoBoldFont16
                
            } else {
                titleLabel.font = Fonts.montserratSemiBoldFont16
            }
            titleLabel.textColor = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
        }
    }
    @IBOutlet weak var describtionLabel: UILabel!{
        didSet {
         //   describtionLabel.text =  LocalizationsKeys.GameballScreen.achievementTitle.rawValue.localized
            
            if Localizator.sharedInstance.language == Languages.arabic {
                describtionLabel.font = Fonts.cairoRegularFont12
                
            } else {
                describtionLabel.font = Fonts.montserratLightFont12
            }
      
        }
    }
    @IBOutlet weak var textField: UITextField!{
        didSet{
            
            if Localizator.sharedInstance.language == Languages.arabic {
                textField.font = Fonts.cairoRegularFont10
                
            } else {
                textField.font = Fonts.montserratLightFont10
            }
        

            textField.textColor = Colors.appGray128
           textField.layer.cornerRadius = 15
            textField.clipsToBounds = true
            textField.backgroundColor = Colors.appGray242
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: textField.frame.height))
            textField.leftViewMode = .always
            if #available(iOS 11.0, *) {
                textField.layer.maskedCorners = [ .layerMinXMinYCorner,.layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBOutlet weak var copyBtn: UIButton!{
        didSet{
            if #available(iOS 11.0, *) {
                copyBtn.layer.maskedCorners = [ .layerMaxXMaxYCorner,.layerMaxXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
            if Localizator.sharedInstance.language == Languages.arabic {
                copyBtn.titleLabel?.font = Fonts.cairoBoldFont12
                
            } else {
                copyBtn.titleLabel?.font = Fonts.montserratSemiBoldFont12
            }
            copyBtn.setTitleColor(.white, for: .normal)
            copyBtn.layer.cornerRadius = 15
            copyBtn.clipsToBounds = true
            copyBtn.backgroundColor = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
