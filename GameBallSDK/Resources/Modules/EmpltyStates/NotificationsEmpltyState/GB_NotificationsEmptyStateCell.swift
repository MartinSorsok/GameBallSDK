//
//  GB_NotificationsEmptyStateCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 11/25/19.
//

import UIKit

class GB_NotificationsEmptyStateCell: UITableViewCell {

    @IBOutlet weak var noNotificationLabel: UILabel!{
        didSet {
            noNotificationLabel.text =  GB_LocalizationsKeys.NotificationsScreen.noNotifications    .rawValue.localized
            
               if GB_Localizator.sharedInstance.language == Languages.arabic {
                    noNotificationLabel.font = Fonts.cairoBoldFont16
                    
                } else {
                    noNotificationLabel.font = Fonts.montserratSemiBoldFont16
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
