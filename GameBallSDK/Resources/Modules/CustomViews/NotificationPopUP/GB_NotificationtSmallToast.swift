//
//  GB_NotificationtSmallToast.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 11/22/19.
//

import UIKit

class GB_NotificationtSmallToast: UIView {


    @IBOutlet weak var NotificationImage: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationDescription: UILabel!
    
    override func draw(_ rect: CGRect) {

        // Drawing code

    }

    override init(frame: CGRect) {

        // Call super init

        super.init(frame: frame)

        // 3. Setup view from .xib file

    }

    required init?(coder aDecoder: NSCoder) {

        // 1. setup any properties here

        // 2. call super.init(coder:)

        super.init(coder: aDecoder)

        // 3. Setup view from .xib file
        self.layer.cornerRadius = 15


    }

    var notificationData: UNNotification? {
           didSet{
               setupUI()
           }
       }
       


       func setupUI(){
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            self.overrideUserInterfaceStyle = .light
        }
           self.layer.cornerRadius = 15
           
           self.layer.masksToBounds = true
           
           if let title = notificationData?.request.content.userInfo[AnyHashable("title")] as? String{
               notificationTitle.text = title
           }
           
           if let body = notificationData?.request.content.userInfo[AnyHashable("body")] as? String{
           notificationDescription.text = body
           }
           
           if let image = notificationData?.request.content.userInfo[AnyHashable("icon")] as? String{
               NetworkManager.shared().loadImage(path: image.replacingOccurrences(of: " ", with: "%20")) { (myImage, error) in
                   if let errorModel = error {
                        Helpers().dPrint(errorModel.description)
                   }
                   else {
                   }
                   if let result = myImage {
                       DispatchQueue.main.async {
                           self.NotificationImage.image = result
                       }
                   }
               }
           }
           
           
//           let origImage = UIImage(named: "iclose_new@2x.png")
//           let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
//           closeBtn.setImage(tintedImage, for: .normal)
//           closeBtn.tintColor = UIColor.init(hex: "CECECE")
//

       }

}
