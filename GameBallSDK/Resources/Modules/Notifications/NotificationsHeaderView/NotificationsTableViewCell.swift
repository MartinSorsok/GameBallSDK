//
//  NotificationsTableViewCell.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 8/15/19.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!{
        didSet{
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                notificationTitle.font = Fonts.cairoBoldFont12
                
            } else {
                notificationTitle.font = Fonts.montserratSemiBoldFont12
            }
        }
    }
    @IBOutlet weak var notificationBody: UILabel!{
        didSet{
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                notificationBody.font = Fonts.cairoRegularFont10
                
            } else {
                notificationBody.font = Fonts.montserratLightFont10
            }
        }
    }
    @IBOutlet weak var notificationDate: UILabel!{
        didSet{
            notificationDate.textColor = Colors.appGray128
            if GB_Localizator.sharedInstance.language == Languages.arabic {
                notificationDate.font = Fonts.cairoRegularFont10
                
            } else {
                notificationDate.font = Fonts.montserratLightFont10
            }
        }
    }
    
    var notification: NotificationGB? {
        didSet {
            
            notificationTitle.text = notification?.titleApp
            notificationBody.text = notification?.bodyApp
            notificationDate.text = formatDate(date: notification?.dateTime ?? "")
            setImage(withURL: notification?.iconPath ?? "https://assets.gameball.co/sample/4.png" )
            
            
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
    
    func formatDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
//        2019-08-08T19:47:42.357
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM"
        
        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)

        } else {
            return "There was an error decoding the string"
        }
        
    }
    func setImage(withURL: String) {
        let path = withURL
        NetworkManager.shared().loadImage(path: path.replacingOccurrences(of: " ", with: "%20")) { (myImage, error) in
            if let errorModel = error {
                 Helpers().dPrint(errorModel.description)
            }
            else {
            }
            if let result = myImage {
                DispatchQueue.main.async {
                    self.notificationImage.image = result
                    self.notificationImage.alpha = 0
                    UIView.animate(withDuration: 1.0, animations: {
                        self.notificationImage.alpha = 1.0
                    })
                }
            }
        }
    }
    
}




