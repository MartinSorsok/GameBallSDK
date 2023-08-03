//
//  ViewController.swift
//  Gameball
//
//  Created by Mahmoud Tarek on 29/07/2023.
//

import UIKit
import GameBallSDK

class ViewController: UIViewController {
    
    var gameball: Gameball?
//    let apiKey = "29c175e1776f40d18592f7537c863f57"
    
    @IBOutlet weak var launchWidgetBtn: UIButton!
    @IBOutlet weak var trackEventBtn: UIButton!
    
    @IBOutlet weak var apiKeyTextField: UITextField!
    @IBOutlet weak var playerIdTextField: UITextField!
    @IBOutlet weak var langTextField: UITextField!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var platformTextField: UITextField!
    @IBOutlet weak var openDetailTextField: UITextField!
    @IBOutlet weak var hideNavigationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        apiKeyTextField.text = "29c175e1776f40d18592f7537c863f57"
        playerIdTextField.text = "Mahmoud"
        
    }
    
    @IBAction func didTapInitSDK(_ sender: UIButton) {
        guard let apiKey = apiKeyTextField.text,
              let playerId = playerIdTextField.text,
                !apiKey.isEmpty,
                !playerId.isEmpty else {
            displaySimpleAlert(title: "Error", desc: "Please enter required fields first")
            return
        }
        
        // Init SDK - Only apiKey is required
        gameball = Gameball(
            apiKey: apiKey,
            lang: langTextField.text,
            shop: shopTextField.text,
            platform: platformTextField.text,
            openDetail: openDetailTextField.text,
            hideNavigation: hideNavigationSwitch.isOn,
            completion: { [weak self] in
                guard let self = self else {return}
                
                DispatchQueue.main.async {
                    self.launchWidgetBtn.isEnabled = true
                    self.trackEventBtn.isEnabled = true
                }
                
                // Register player after obtaining Firebase Token - only playerUniqueId is required
                self.gameball?.registerPlayer(
                    playerUniqueId: playerId,
                    playerTypeId: "1",
                    deviceToken: "firebase_token",
                    mobile: "010000000",
                    email: "email@test.com",
//                    referrerCode: "GB_X1", // Must be valid, otherwise API will fail
                    playerAttributes: [
                        "custom_attribute": "custom_value",
                        "country": "Egypt"
                    ], completion: { gameballId, error in
                        if let error = error {
                            print("Registration failed with error: \(error)")
                        } else if let gameballId = gameballId {
                            print("Registered player with gameballId: \(gameballId)")
                        }
                    }
                )
            }
        )
    }

    @IBAction func didTapLaunch(_ sender: UIButton) {
        gameball?.showProfile(completion: { viewController, errorMessage in
            guard let gameBallVC = viewController else {return}
            gameBallVC.modalPresentationStyle = .fullScreen
            self.present(gameBallVC, animated: true, completion: nil)
        })
    }
    
    @IBAction func didTapTrackEvent(_ sender: UIButton) {
        let events: [Event] = [
            Event(eventName: "coin_purchase", params: ["price": "100", "currency": "EGP"]),
            Event(eventName: "click_X_screen", params: ["screen_name": "X_Y_Z", "source": "A_B_C"]),
        ]
        gameball?.sendEvents(events: events)
    }
    
    private func displaySimpleAlert(title: String, desc: String) {
        let alert = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

