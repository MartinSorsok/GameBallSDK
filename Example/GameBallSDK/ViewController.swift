//
//  ViewController.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 07/23/2019.
//  Copyright (c) 2019 Martin Sorsok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showProfile(_ sender: Any) {
        if let myDelegate = UIApplication.shared.delegate as? AppDelegate {
            guard let vc = myDelegate.gameballApp?.launchGameball() else {return}
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }
    
}

