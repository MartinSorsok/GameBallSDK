//
//  ViewController.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 07/23/2019.
//  Copyright (c) 2019 Martin Sorsok. All rights reserved.
//

import UIKit
import GameBallSDK

class ViewController: UIViewController {
    var gameballApp: GameballApp?

    override func viewDidLoad() {
        super.viewDidLoad()
        let gameball = GameballApp.init(APIKey: "8fdfd2dffd-9mnvhu25d6c3d")
        self.gameballApp = gameball
        self.gameballApp?.registerPlayer(withPlayerId: "Matrix")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showProfile(_ sender: Any) {
            guard let vc = self.gameballApp?.launchGameball() else {return}
            self.present(vc, animated: true, completion: nil)
    }
    
}

