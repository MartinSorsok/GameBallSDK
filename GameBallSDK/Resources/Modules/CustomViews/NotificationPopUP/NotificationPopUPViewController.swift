//
//  NotificationPopUPViewController.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 6/25/19.
//

import UIKit
import UserNotifications
class NotificationPopUPViewController: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var NotificationImage: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationDescription: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    
    
    
    var notificationData: UNNotification? {
        didSet{
            setupUI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    func setupUI(){
        mainView.layer.cornerRadius = 15
        
        
        
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
        
        
        let origImage = UIImage(named: "icon_outline_14px_close@2x.png")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        closeBtn.setImage(tintedImage, for: .normal)
        closeBtn.tintColor = UIColor.init(hex: "CECECE")
  

    }
    
    
    //MARK:- Actions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func notificationBtnAction(_ sender: Any) {
        
    }
}
