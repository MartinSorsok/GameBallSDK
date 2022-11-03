//
//  GB_WEBVIEWWIDGETViewController.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 1/28/21.
//

import UIKit
import WebKit
class GB_WEBVIEWWIDGETViewController: BaseViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var playerID = ""
    var color = ""
    var APIKEY = ""
    var lang = ""
    @IBOutlet weak var closeBtn: UIButton! {
        didSet {
            let origImage = UIImage(named: "icon_outline_14px_close@2x.png")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            closeBtn.setImage(tintedImage, for: .normal)
            closeBtn.tintColor = UIColor.white.withAlphaComponent(0.5)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://m.gameball.app?main=\(color)&playerid=\(playerID)&lang=\(lang)&apiKey=\(APIKEY)"
        let GB_url = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "" )
        webView.load(URLRequest(url: GB_url! ))
        webView.allowsBackForwardNavigationGestures = true
        
    }



    @IBAction func closeBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
