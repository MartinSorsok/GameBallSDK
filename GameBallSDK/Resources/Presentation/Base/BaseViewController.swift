//
//  BaseViewController.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/8/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    
//    private let activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .whiteLarge)
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        indicator.color = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F") 
//        return indicator
//    }()
    
    private var activityIndicator: NVActivityIndicatorView!
    
    

    
    func startLoading() {
        let x = view.bounds.midX - ( 100 * 0.5)
        let y = view.bounds.midY - ( 100 * 0.5 )
        
        //        , y:
        let frame = CGRect(x: x, y: y, width: 100, height: 100)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                            type: NVActivityIndicatorType.ballClipRotatePulse)
        let animationTypeLabel = UILabel(frame: frame)
        
        //        animationTypeLabel.text = String(index)
        animationTypeLabel.sizeToFit()
        animationTypeLabel.textColor = UIColor.black
        animationTypeLabel.frame.origin.x += 5
        animationTypeLabel.frame.origin.y += CGFloat(100) - animationTypeLabel.frame.size.height
        
        activityIndicatorView.padding = 20
        activityIndicatorView.color = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F") ?? .black
        self.activityIndicator =  activityIndicatorView
        view.addSubview(activityIndicator)
        
//        if #available(iOS 11.0, *) {
//            activityIndicatorNew2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        } else {
//            // Fallback on earlier versions
//        }
//
//        if #available(iOS 11.0, *) {
//            activityIndicatorNew2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 11.0, *) {
//            activityIndicatorNew2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 11.0, *) {
//            activityIndicatorNew2.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        } else {
//            // Fallback on earlier versions
//        }
        
        activityIndicator.startAnimating()
    }
    
    func endLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()

            self.activityIndicator.removeFromSuperview()
        }
    
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLanguage()
        //setupFonts()
    }
    
    
    func setupViewLanguage(){
        
        if Localizator.sharedInstance.language == Languages.arabic {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft

        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
        }
    }
    
 
//    func startLoading(with loadingView: UIView) {
//        self.loadingView = loadingView
//        self.view.addSubview(loadingView)
//        loadingView.frame = view.bounds
//
//
//    }
//
//    func stopLoading() {
//        self.loadingView?.removeFromSuperview()
//        self.loadingView = nil
//    }
    
    
}

extension BaseViewController: BaseCoordinatorDelegate {
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
