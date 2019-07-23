//
//  BaseViewController.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/8/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = Colors.appOrange
        return indicator
    }()
    
    func startLoading() {
        view.addSubview(activityIndicator)
        
        if #available(iOS 11.0, *) {
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
 
        if #available(iOS 11.0, *) {
            activityIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            activityIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        
        activityIndicator.startAnimating()
    }
    
    func endLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        
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
