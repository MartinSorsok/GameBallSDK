//
//  ViewController.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 07/23/2019.
//  Copyright (c) 2019 Martin Sorsok. All rights reserved.
//

import UIKit
import GameBallSDK
import FirebaseMessaging
class ViewController: UIViewController, MessagingDelegate {
    let gameball =  GameballApp()
    var FCMtoken = ""
    override func viewDidLoad() {
        super.viewDidLoad()    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showProfile(_ sender: Any)  {
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
              self.launchGameball(withDeviceToken: token)
          }
        }

    }
    
    func launchGameball(withDeviceToken: String) {
        //Change the APIKEY , Language , player ID , player attributes based on your references
        let playerAttributes: [String : Any] = [
                "displayName": "Martin spiderman",
                "email": "example@example.com"
            ]
        gameball.launchGameball(
            withAPIKEY: "5209563812d84499b8302d2eb1e107ae",
            withPlayerUniqueId: "Martin Sorsok",
            withPlayerAttributes: playerAttributes,
            withDeviceToken: withDeviceToken,
            withLang: "en") { (GBVC, error) in
           guard let gameBallVC = GBVC else {return}
             self.present(gameBallVC, animated: true, completion: nil)
          }
    }
}

