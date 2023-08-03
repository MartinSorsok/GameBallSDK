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
    var color: String? = ""
    var APIKEY = ""
    var lang: String? = ""
    var openDetail: String?
    var hideNavigation: Bool?
    
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
        
        /*
         let url = "https://m.gameball.app?main=\(color)&playerid=\(playerID)&lang=\(lang)&apiKey=\(APIKEY)"
         let GB_url = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "" )
         webView.load(URLRequest(url: GB_url! ))
         */
        
        let baseURL = "https://m.gameball.app"

        var urlComponents = URLComponents(string: baseURL)
        var queryItems = [URLQueryItem]()

        if var color = color {
            if (color.first == "#") {
                color.remove(at: color.startIndex)
            }
            queryItems.append(URLQueryItem(name: "main", value: color))
        }
        
        queryItems.append(URLQueryItem(name: "playerid", value: playerID))
        queryItems.append(URLQueryItem(name: "lang", value: lang))
        queryItems.append(URLQueryItem(name: "apiKey", value: APIKEY))
        queryItems.append(URLQueryItem(name: "os", value: "iOS"))
        queryItems.append(URLQueryItem(name: "sdk", value: NetworkManager.shared().sdkVersion))
        if let openDetail = openDetail {
            queryItems.append(URLQueryItem(name: "openDetail", value: openDetail))
        }
        if let hideNavigation = hideNavigation {
            queryItems.append(URLQueryItem(name: "hideNavigation", value: hideNavigation ? "true" : "false"))
        }

        urlComponents?.queryItems = queryItems
        
        
        guard let url = urlComponents?.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid URL")
            return
        }

        guard let encodedURL = URL(string: url) else {
            print("Invalid encoded URL")
            return
        }
        
        webView.load(URLRequest(url: encodedURL))
        
        webView.allowsBackForwardNavigationGestures = true
    }



    @IBAction func closeBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
