//
//  baseFile.swift
//  gameball_SDK
//
//  Created by Martin Sorsok on 2/2/19.
//  Copyright © 2019 Martin Sorsok. All rights reserved.
//

import UIKit
import UserNotifications
open class GameballApp: NSObject {
    
    // ToDo: fetch bot style won gameball init insetead of fetching VC
    static var clientBotStyle: ClientBotStyle?
    var playerUniqueId: String?
    var APIKey: String?
    var holdReference: String?
    
    
//    public init() {
//        super.init()
        
//        self.setupFonts()
//        self.fetchBotStyle()
        
//        NetworkManager.shared().registerAPIKey(APIKey: APIKey)
        //        self.registerPlayer(withPlayerId: playerId, withCategroyId: categoryId)
        // I should return after fetching ot style
        
        
//    }
    
    
//    public init(APIKey: String,language: String = "en") {
//        super.init()
//        self.setupFonts()
//        self.fetchBotStyle()
//
//        language == Languages.arabic.rawValue  ? NetworkManager.shared().registerAPIKey(APIKey: APIKey,language:.arabic ) : NetworkManager.shared().registerAPIKey(APIKey: APIKey)
//    }
//
    
    
    public func launchGameball(withAPIKEY: String, withPlayerUniqueId: String, withPlayerAttributes: [String:Any],withDeviceToken: String, withLang:String, completion:  ((_ success: UIViewController?, _ errorDescription: String?)->())? = nil) {
        
        // Present View "Modally"
        if !(Reachability.isConnectedToNetwork())  {
            completion?(NoInternetViewController(),nil)
        }
        if !(withAPIKEY.isEmpty) {
            NetworkManager.shared().APIKey = withAPIKEY
            self.registerPlayer(withPlayerUniqueId: withPlayerUniqueId, withPlayerAttributes: withPlayerAttributes,withDeviceToken: withDeviceToken)
            if !(withPlayerUniqueId.isEmpty) {
                NetworkManager.shared().load(path: APIEndPoints.getBotStyle, method: RequestMethod.GET, params: [:], modelType: GetClientBotStyleResponse.self) { (data, error) in
                    guard let errorModel = error else {
                        if data != nil {
                            GameballApp.clientBotStyle = (data as? GetClientBotStyleResponse)?.response
                            NetworkManager.shared().clientBotSettings = true
                            DispatchQueue.main.async {
                                let color = GameballApp.clientBotStyle?.botMainColor ?? ""
                                let GB_ViewController = self.prepareGBVC(withAPIKEY: withAPIKEY, withPlayerUniqueId: withPlayerUniqueId, withColor: String(color.dropFirst()), withLang: withLang)
                                completion?(GB_ViewController, nil)
                            }
                        }
                        return
                    }
                    // ToDo: return the error model
                    Helpers().dPrint("Could not get client bot settings")
                    NetworkManager.shared().clientBotSettings = false
                    //            self.fetchBotStyle()
                    DispatchQueue.main.async {
                        let color = GameballApp.clientBotStyle?.botMainColor ?? ""
                        let GB_ViewController = self.prepareGBVC(withAPIKEY: withAPIKEY, withPlayerUniqueId: withPlayerUniqueId, withColor: String(color.dropFirst()), withLang: withLang)
                        completion?(GB_ViewController, errorModel.description)
                    }
                    
                }
            } else {
                completion?(nil,"Gameball Player Id is not set...")
            }
        } else {
            completion?(nil,"Gameball API Key is not set...")
            
        }
    }
    private func prepareGBVC(withAPIKEY: String,withPlayerUniqueId: String,withColor: String, withLang:String) -> UIViewController? {

            let GB_ViewController = GB_WEBVIEWWIDGETViewController(nibName: String(describing: GB_WEBVIEWWIDGETViewController.self), bundle: nil)
            GB_ViewController.APIKEY = withAPIKEY
            GB_ViewController.playerID = withPlayerUniqueId
            GB_ViewController.color = withColor
            GB_ViewController.lang = withLang
            return GB_ViewController
    }
//    public func launchGameball(withAPIKEY: String,withPlayerUniqueId: String,withColor: String, withLang:String) -> UIViewController? {
//
//       // Present View "Modally"
//        guard Reachability.isConnectedToNetwork() else {
//            return NoInternetViewController()
//        }
//        if !(withAPIKEY.isEmpty) {
//            NetworkManager.shared().APIKey = withAPIKEY
//            if !(withPlayerUniqueId.isEmpty) {
//
//                let GB_ViewController = GB_WEBVIEWWIDGETViewController(nibName: String(describing: GB_WEBVIEWWIDGETViewController.self), bundle: nil)
//                GB_ViewController.APIKEY = withAPIKEY
//                GB_ViewController.playerID = withPlayerUniqueId
//                GB_ViewController.color = withColor
//                GB_ViewController.lang = withLang
//                return GB_ViewController
//                }
//                else {
//                    Helpers().dPrint("Gameball Player Id is not set...")
//                    return nil
//                }
//
//        }
//        else {
//            Helpers().dPrint("Gameball API Key is not set...")
//            return nil
//        }
//
//        return nil
//    }
    

    public func notificationPopUP(notification: UNNotification)  {
        
        
//        print(notification.request.content.userInfo["type"])
        
                if notification.request.content.userInfo["type"] as? String == "Small Toast" {
                      guard let myView = Bundle.main.loadNibNamed("NotificationtSmallToast", owner: self, options: nil)?[0] as? GB_NotificationtSmallToast else {return}
                    
                    myView.notificationData = notification
                    UIApplication.shared.keyWindow?.rootViewController?.view.GB_showToast(myView, position: .top)
                    
                    
                }
                else if notification.request.content.userInfo["type"] as? String == "Large Toast"{
                    guard let myVC = Bundle.main.loadNibNamed("NotificationPopUPView", owner: self, options: nil)?[0] as? NotificationPopUPViewController else {return}
                    myVC.notificationData = notification
                UIApplication.shared.keyWindow?.rootViewController?.present(myVC , animated: true, completion: nil)
                    
                }  else {
                    guard let myVC = Bundle.main.loadNibNamed("NotificationPopUpFullScreenViewController", owner: self, options: nil)?[0] as? NotificationPopUpFullScreenViewController else {return}
                    myVC.notificationData = notification
                UIApplication.shared.keyWindow?.rootViewController?.present(myVC , animated: true, completion: nil)
                    
                }

  
        
    }
    

    public func recievedDynamicLink(url: URL){
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return }
        for queryItem in queryItems{
            Helpers().dPrint("Parameter \(queryItem.name) has value of \(queryItem.value ?? "")")
            if queryItem.name == "GBReferral" {
                NetworkManager.shared().referalCode = (queryItem.value ?? "")
                
            }
            
        }
    }
    
    
    // Friend Referral
    public func friendReferral(playerUniqueId: String,playerAttributes: [String:Any] = [:], completion: @escaping (String) -> Void)  {
        return NetworkManager.shared().friendReferral(playerUniqueId: playerUniqueId,playerAttributes: playerAttributes, completion: completion)
    }
    
    // register with client provided player id
    public func registerPlayer(withPlayerUniqueId: String, withPlayerTypeId: String = "",withPlayerAttributes: [String: Any] = [:], withDeviceToken: String = "") {
        NetworkManager.shared().registerPlayer(playerUniqueId: withPlayerUniqueId, categoryId: withPlayerTypeId , playerAttributes: withPlayerAttributes, withDeviceToken: withDeviceToken)
    }
    
    
    // register without client provided player id
    public func registerPlayer(withCategroyId: String = "") {
        let uuid = NSUUID().uuidString.lowercased()
        // NetworkManager.shared().registerPlayer(playerId: uuid, categoryId: withCategroyId)
    }
    
    
    public func registerDevice(withToken: String) {
        // ToDo: send token to gameball servers
        // a player should be registered to link token with player
        NetworkManager.shared().registerDevice(withToken: withToken)
    }
    
    
    
    
    // Send action withMeta Data events
//    public func sendActionWithMetaData(events: [String : [String : Any]] , completion: @escaping  ((_ success: Any?, _ errorDescription: Any?)->())) {
//
//        NetworkManager.shared().sendAction(events: events) { (responseObject, error) in
//            if error == nil {
//                Helpers().dPrint("done ..sendAction..")
////                Helpers().dPrint(responseObject)
//                completion(responseObject?.response, nil)
//            }
//            else {
//                Helpers().dPrint("failed sendAction")
//                completion(responseObject?.response, error?.description)
//            }
//        }
//    }
//
//    public func sendActionWithOutMetaData(events: [String : Any] , completion: @escaping  ((_ success: Bool?, _ errorDescription: String?)->())) {
//
//        NetworkManager.shared().sendAction(events: events) { (responseObject, error) in
//            if error == nil {
//                Helpers().dPrint("done ..sendAction..")
////                Helpers().dPrint(responseObject)
//                completion(responseObject?.success, nil)
//            }
//            else {
//                Helpers().dPrint("failed sendAction")
//                completion(responseObject?.success, "Failed to send Action")
//            }
//        }
//    }
    
    
    
    //4.2    Generate OTP
//    public func generateOTP(completion: @escaping  ((_ success: Bool?, _ errorDescription: String?)->())) {
//        NetworkManager.shared().generateOTP() { (responseObject, error) in
//            if error == nil {
//                Helpers().dPrint("done ....")
//                completion(true, nil)
//            }
//            else {
//                Helpers().dPrint("failed")
//                completion(false, error?.description)
//            }
//        }
//    }
    
    //4.9   Get Player Balance
//    public func getPlayerBalance(completion: @escaping  ((_ success: Bool?, _ errorDescription: String?)->())) {
//        NetworkManager.shared().getPlayerBalance() { (responseObject, error) in
//            if error == nil {
//                Helpers().dPrint("done ....")
//                completion(true, nil)
//            }
//            else {
//                Helpers().dPrint("failed")
//                completion(false, error?.description)
//            }
//
//        }
//    }
    //4.3    Reward OTP
//    public func rewardPoints(transactionOnClientSystemId: String ,amount: Int = 0,completion: @escaping  ((_ success: Bool?, _ errorDescription: String?)->())) {
//        NetworkManager.shared().rewardPoints(transactionOnClientSystemId: transactionOnClientSystemId, amount: amount) { (responseObject, error) in
//            if error == nil {
//                Helpers().dPrint("done ....")
//                completion(true, nil)
//            }
//            else {
//                Helpers().dPrint("failed")
//                completion(false, error?.description)
//            }
//        }
//    }
    
    //4.5    Hold Points
    
//    public func holdPoints(OTP: String ,amount: Int = 0,completion: @escaping  ((_ success: String?, _ errorDescription: String?)->())) {
//        NetworkManager.shared().holdPoints(OTP: OTP, amount: amount) { (responseObject, error) in
//            if error == nil {
//                Helpers().dPrint("done holdPoints ....")
//                self.holdReference = responseObject?.response?.holdReference ?? ""
//                //                 self.dPrint(responseObject?.response?.holdReference as Any)
//                completion(responseObject?.response?.holdReference ?? "", nil)
//            }
//            else {
//                Helpers().dPrint("failed")
//                completion(nil, error?.description)
//            }
//        }
//    }
    
    //4.4    Redeem Points
    
//    public func redeemPoints(transactionOnClientSystemId: String ,holdReference: String ,amount: Int = 0,completion: @escaping  ((_ success: Bool?, _ errorDescription: String?)->())) {
//        NetworkManager.shared().redeemPoints(transactionOnClientSystemId: transactionOnClientSystemId, holdReference: holdReference, amount: amount) { (responseObject, error) in
//            if error == nil {
//                Helpers().dPrint("done redeemPoints ....")
//                completion(true, nil)
//            }
//            else {
//                Helpers().dPrint("failed")
//                completion(nil, error?.description)
//            }
//        }
//    }
    
    //4.6    Reverse Points
    
//    public func reversePoints(holdReference: String,completion: @escaping  ((_ success: Bool?, _ errorDescription: String?)->())) {
//        NetworkManager.shared().reversePoints( holdReference: holdReference) { (responseObject, error) in
//            if error == nil {
//                Helpers().dPrint("done redeemPoints ....")
//                completion(true, nil)
//            }
//            else {
//                Helpers().dPrint("failed")
//                completion(nil, error?.description)
//            }
//        }
//    }
    //    public func configureFireBase() {
    //        if let filePath = Bundle.init(for: type(of: self)).path(forResource: "GameBallSDK-Info", ofType: "plist") {
    //
    //
    //            let manualOptions = FirebaseOptions.init(googleAppID: "1:252563989296:ios:070bea370ad08516", gcmSenderID: "550082315977")
    //            manualOptions.bundleID = "org.cocoapods.GameBallSDK"
    //            manualOptions.apiKey = "AIzaSyBuUTVn-JHAPOBk7SJla8V0lqdbFcBdv0Q"
    //            manualOptions.projectID = "gameballsdk"
    ////            manualOptions.clientID = "252563989296-ldf2tn2hp97vklt576kl4ao109bf7js8.apps.googleusercontent.com"
    //            FirebaseApp.configure(name: "GameballSDK", options: manualOptions)
    //        }
    //    }
    
    //    public func configureFirebaseTest() {
    //        let manualOptions = FirebaseOptions.init(googleAppID: "1:6155436118:ios:5f6ec0ebbfd46fca", gcmSenderID: "6155436118")
    //        manualOptions.bundleID = "abodeif.gameball"
    //        manualOptions.apiKey = "AIzaSyAckaZGugjHFE5vVpT6fED7yD7JD8MEnYc"
    //        manualOptions.projectID = "gameballios"
    //        FirebaseApp.configure(options: manualOptions)
    //    }
    
    //    public func getFirebaseApp() -> [String : FirebaseApp]? {
    //        return FirebaseApp.allApps
    //    }
    
    
    
    
}

