//
//  BaseViewController.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/8/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    let settings = GameballApp.clientBotStyle

    private var activityIndicator: NVActivityIndicatorView!
    
    private var isLoading = false

    
    func startLoading() {
        if !isLoading {
        isLoading = true
        let x = view.bounds.midX - ( 100 * 0.5)
        let y = view.bounds.midY - ( 100 * 0.5 )
        
        let frame = CGRect(x: x, y: y, width: 100, height: 100)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                            type: NVActivityIndicatorType.ballClipRotatePulse)
        let animationTypeLabel = UILabel(frame: frame)
        
        animationTypeLabel.sizeToFit()
        animationTypeLabel.textColor = UIColor.black
        animationTypeLabel.frame.origin.x += 5
        animationTypeLabel.frame.origin.y += CGFloat(100) - animationTypeLabel.frame.size.height
        
        activityIndicatorView.padding = 20
        activityIndicatorView.color = Colors.appMainColor ?? .black
        self.activityIndicator =  activityIndicatorView
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        }
    }
    
    func endLoading() {
        isLoading = false
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLanguage()
        //setupFonts()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    
    func setupViewLanguage(){
        
        if GB_Localizator.sharedInstance.language == Languages.arabic {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft

        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
        }
    }
    
    func isOneTabBar() -> Bool {
        if !(settings?.enableLeaderboard ?? false)
        && !(settings?.enableAchievements ?? false)
        && !(settings?.enableNotifications ?? false)
            && (settings?.isReferralOn ?? false) {
            return true
        }
        if (settings?.enableLeaderboard ?? false)
        && !(settings?.enableAchievements ?? false)
        && !(settings?.enableNotifications ?? false)
            && !(settings?.isReferralOn ?? false) {
            return true
        }
        if !(settings?.enableLeaderboard ?? false)
        && settings?.enableAchievements ?? false
        && !(settings?.enableNotifications ?? false)
            && !(settings?.isReferralOn ?? false) {
            return true
        }
        
        if !(settings?.enableLeaderboard ?? false)
        && !(settings?.enableAchievements ?? false)
        && settings?.enableNotifications ?? false
        && !(settings?.isReferralOn ?? false) {
            return true
        }
        
        return false
        
    }

}

extension BaseViewController: BaseCoordinatorDelegate {
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension String {
     func getFormattedDate(string: String) -> String{
        let dateFormatter = DateFormatter()
        
        //"2019-08-08T19:47:42.007"
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss +zzzz" // This formate is input formated .
        
        let formateDate = dateFormatter.date(from:string)
        dateFormatter.dateFormat = "dd-MM" // Output Formated
        
        return dateFormatter.string(from: formateDate ?? Date())
    }
}
