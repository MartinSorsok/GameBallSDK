//
//  NetworkManager.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/3/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation
import UIKit

typealias JSON = [String: Any]

class NetworkManager:NSObject {
    
    let urlSession: URLSession
    let connectionScheme: String
    let host: String
    var APIKey: String
    var currentLanguage: Languages
    var referalCode = ""
    var playerId: String
    var categoryId: String
    var clientBotSettings: Bool?
    
    private static var sharedManager:NetworkManager = {
        let sessionConfiguration = URLSessionConfiguration.default
        if #available(iOS 11.0, *) {
            sessionConfiguration.waitsForConnectivity = true
        } else {
            // Fallback on earlier versions
        }
        let urlSession = URLSession(configuration: sessionConfiguration)
        let baseURL = APIEndPoints.base_URL
        let scheme = "https"
        let host = APIEndPoints.base_URL
//        let port = APIEndPoints.appPort
        let APIKey = ""
        let playerId = ""
        let categoryId = ""
        let currentLanguage = Languages.english
        let networkManager = NetworkManager.init(urlSession: urlSession, connectionScheme: scheme, host: host, APIKey: APIKey, playerId: playerId, categoryId: categoryId,currentLanguage: currentLanguage)
        return networkManager
    }()
    
    
    private init(urlSession: URLSession, connectionScheme: String, host: String, APIKey: String, playerId: String, categoryId: String , currentLanguage: Languages) {
        self.urlSession = urlSession
        self.connectionScheme = connectionScheme
        self.host = host
        self.APIKey = APIKey
        self.playerId = playerId
        self.categoryId = categoryId
        self.currentLanguage = currentLanguage
    }
    
    
    static func shared() -> NetworkManager {
        return sharedManager
    }
    
    
    func isAPIKeySet() -> Bool {
        return (self.APIKey.count > 0) ? true : false
    }
    
    func isBotSettingsSet() -> Bool {
        return clientBotSettings ?? false
    }
    func isDynamicSet() -> Bool {
        return (self.referalCode.count > 0) ? true : false
    }
    
    func isPlayerIdSet() -> Bool {
        return (self.playerId.count > 0) ? true : false
    }

    func loadDebug<T>(path: String, method: RequestMethod, params: JSON, modelType: T.Type, completion: @escaping (Any?, ServiceError?) -> ()) where T:Codable {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var request = URLRequest(path: path, method: method, params: params)
        self.adaptRequest(urlRequest: &request)
        // Sending request to the server.
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            // Parsing incoming data
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    if let data = data {
                        let JSONString = String(data: data, encoding: String.Encoding.utf8)
                        print(JSONString ?? "Could not print Json")
                    }
                case 403:
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    completion(nil, ServiceError.invalidAPIKey)
                default:
                    completion(nil, ServiceError.serverError)
                }
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                completion(nil, nil)
            } else {
                completion(nil, ServiceError.serverError)
            }
        }
        
        task.resume()
    }

    
    func load<T>(path: String, method: RequestMethod, params: JSON, modelType: T.Type, completion: @escaping (Any?, ServiceError?) -> ()) where T:Codable {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var request = URLRequest(path: path, method: method, params: params)
        self.adaptRequest(urlRequest: &request)
        // Sending request to the server.
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            var object: T? = nil
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
//                    guard let data = data else { return }
//                    do {
//                        let decoder = JSONDecoder()
//                        let gitData = try decoder.decode(modelType.self, from: data)
//                        print(gitData)
//                        object = gitData
//                        completion(object, nil)
//
//                    } catch let err {
//                        print("Err", err)
//                    }
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(modelType.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        object = tempObject
                        completion(object, nil)
                    }
                case 403:
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    completion(nil, ServiceError.invalidAPIKey)
                default:
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    
    
    func loadImage(path: String, completion: @escaping (UIImage?, ServiceError?) -> ()) {
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        var modifiedPath = path
        if path.contains("~") {
            modifiedPath = path.replacingOccurrences(of: "~", with: "")
        }
//        var request = URLRequest(path: modifiedPath)
        let url = URL(string: modifiedPath)
        guard let myUrl = url else {
            print("bad image url .......")
            return
        }
        var req = URLRequest(url: myUrl);
//        var request = URLRequest(path: modifiedPath)
        self.adaptRequest(urlRequest: &req)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    completion(image, nil)
                }
                else {
                    let errorObject = ["ErrorMsg":"The image file seems to be corrupted, check the URL: \(String(describing: req.url?.absoluteString))"]
                    let error = ServiceError.init(json: errorObject)
                    completion(nil, error)
                }
            } else {
                completion(nil, ServiceError.serverError)
            }
        }
        task.resume()

        
//        if let url = url {
//
//        }
//
//        self.adaptRequest(urlRequest: &request)
//        let task = self.urlSession.dataTask(with: request) { data, response, error in
//            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
//                if let imageData = data {
//                    let image = UIImage(data: imageData)
//                    completion(image, nil)
//                }
//                else {
//                    let errorObject = ["ErrorMsg":"The image file seems to be corrupted, check the URL: \(String(describing: request.url?.absoluteString))"]
//                    let error = ServiceError.init(json: errorObject)
//                    completion(nil, error)
//                }
//            } else {
//                completion(nil, ServiceError.serverError)
//            }
//        }
//        task.resume()
    }

    
    // Get playerCategoryId from shared preferences
    func sendAction(events: [String : Any], completion: @escaping ((_ response: PostActionResponse?, _ error: ServiceError?)->())) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
//        params["ChallengeAPIIDs"] = challengeAPIIDs
//        params["QuestAPIID"] = questAPIID
        params["events"] = events
        
        
        params["PlayerUniqueID"] = self.playerId
//        params["PlayerCategoryID"] = self.pla
//        params["Amount"] = amount
//        params["isPositive"] = isPostive
        
        print(params)
        
        var request = URLRequest(path: APIEndPoints.postAction, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(PostActionResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(tempObject, nil)
                    }
                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                case 400:
                    print("400")
                    
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(PostActionResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(nil, ServiceError.custom(tempObject.methodName ?? ""))
                    }
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    
    //generateOTP
    
    func generateOTP(completion: @escaping ((_ response: GenerateOTPResponse?, _ error: ServiceError?)->())) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
     
        params["PlayerUniqueID"] = self.playerId
        params["TransactionTime"] = Helpers().getTransactionTime()
        params["BodyHashed"] = Helpers().getBodyHashed(playerUniqueID: self.playerId, amount: "")
        
        print(params)
        
        var request = URLRequest(path: APIEndPoints.generateOTP, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(GenerateOTPResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(tempObject, nil)
                    }
                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                case 400:
                    print("400")
                    
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(GenerateOTPResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(nil, ServiceError.custom(tempObject.errorMsg ?? ""))
                    }
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    
    
    // 4.9 getPlayerBalance
    
    func getPlayerBalance(completion: @escaping ((_ response: GenerateOTPResponse?, _ error: ServiceError?)->())) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
        
        params["PlayerUniqueID"] = self.playerId
        params["BodyHashed"] = Helpers().getBodyHashed(playerUniqueID: self.playerId, amount: "")
        print(params)
        
        var request = URLRequest(path: APIEndPoints.getPlayerBalance, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(GenerateOTPResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(tempObject, nil)
                    }
                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                case 400:
                    print("400")
                    
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(GenerateOTPResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(nil, ServiceError.custom(tempObject.errorMsg ?? ""))
                    }
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    //4.3    Reward Points
    
    func rewardPoints(transactionOnClientSystemId: String = "",amount: Int = 0,completion: @escaping ((_ response: RewardPointsResponse?, _ error: ServiceError?)->())) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
        
        params["PlayerUniqueID"] = self.playerId
        params["TransactionTime"] = Helpers().getTransactionTime()
        params["BodyHashed"] = Helpers().getBodyHashed(playerUniqueID: self.playerId, amount: String(amount))
        params["TransactionOnClientSystemId"] = transactionOnClientSystemId
        params["Amount"] = amount

        print(params)
        
        var request = URLRequest(path: APIEndPoints.rewardPoints, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(RewardPointsResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(tempObject, nil)
                    }
                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                case 400:
                    print("400")
                    
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(RewardPointsResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(nil, ServiceError.custom(tempObject.errorMsg ?? ""))
                    }
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    
    
    //4.5    Hold Points
    func holdPoints(OTP: String = "",amount: Int = 0,completion: @escaping ((_ response: HoldPointsResponse?, _ error: ServiceError?)->())) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
        
        params["PlayerUniqueID"] = self.playerId
        params["TransactionTime"] = Helpers().getTransactionTime()
        params["BodyHashed"] = Helpers().getBodyHashed(playerUniqueID: self.playerId, amount: String(amount))
        params["OTP"] = OTP
        params["Amount"] = amount
        
        print(params)
        
        var request = URLRequest(path: APIEndPoints.holdPoints, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(HoldPointsResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(tempObject, nil)
                    }
                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                case 400:
                    print("400")
                    
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(HoldPointsResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(nil, ServiceError.custom(tempObject.errorMsg ?? ""))
                    }
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    
    
    //4.4    Redeem Points
    func redeemPoints(transactionOnClientSystemId: String = "",holdReference: String = "",amount: Int = 0,completion: @escaping ((_ response: HoldPointsResponse?, _ error: ServiceError?)->())) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
        
        params["PlayerUniqueID"] = self.playerId
        params["TransactionTime"] = Helpers().getTransactionTime()
        params["BodyHashed"] = Helpers().getBodyHashed(playerUniqueID: self.playerId, amount: String(amount))
        params["TransactionOnClientSystemId"] = transactionOnClientSystemId
        params["Amount"] = amount
        params["HoldReference"] = holdReference

        print(params)
        
        var request = URLRequest(path: APIEndPoints.redeemPoints, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(HoldPointsResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(tempObject, nil)
                    }
                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                case 400:
                    print("400")
                    
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(HoldPointsResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(nil, ServiceError.custom(tempObject.errorMsg ?? ""))
                    }
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    
    //4.6    Reverse Points
    func reversePoints(holdReference: String = "",completion: @escaping ((_ response: HoldPointsResponse?, _ error: ServiceError?)->())) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
        
        params["PlayerUniqueID"] = self.playerId
        params["TransactionTime"] = Helpers().getTransactionTime()
        params["BodyHashed"] = Helpers().getBodyHashed(playerUniqueID: self.playerId, amount: "")
        params["HoldReference"] = holdReference
        
        print(params)
        
        var request = URLRequest(path: APIEndPoints.reversePoints, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(HoldPointsResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(tempObject, nil)
                    }
                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                case 400:
                    print("400")
                    
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(HoldPointsResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        completion(nil, ServiceError.custom(tempObject.errorMsg ?? ""))
                    }
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
    }
    func registerPlayerRequest(playerUniqueId: String, playerCategroyId: String,deviceToken: String = "", completion: @escaping ((_ response: RegisterPlayerResponse?, _ error: ServiceError?)->())) {
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
        params["PlayerUniqueID"] = playerUniqueId
        params["PlayerCategoryID"] = playerCategroyId
        // ToDo: generate firebase token
        
        params["DeviceToken"] = deviceToken
        params["OSType"] = "iPhone/iPad"
        
        var request = URLRequest(path: APIEndPoints.registerPlayer, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<300):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(RegisterPlayerResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        
//                        let data = NSKeyedArchiver.archivedData(withRootObject: tempObject.response)
//                        UserDefaults.standard.set(data, forKey: UserDefaultsKeys.PlayerInfo.rawValue)
                        
                        UserProfileCache.save(tempObject.response)
                        completion(tempObject, nil)

                    }
                    

                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()


    }
    func friendReferralRequest(withReferralCode: String,playerUniqueId: String, playerCategroyId: Int = 0, completion: @escaping ((_ response: FriendReferralResponse?, _ error: ServiceError?)->())) {
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        
        var params: JSON = [:]
        params["PlayerCode"] = withReferralCode
        params["NewPlayerCategoryID"] = playerCategroyId
        params["NewPlayerUniqueID"] = playerUniqueId
        
        var request = URLRequest(path: APIEndPoints.friendReferral, method: .POST, params: params)
        self.adaptRequest(urlRequest: &request)
        
        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case (200..<401):
                    // Parsing incoming data
                    if let data = data {
                        guard let tempObject = try? JSONDecoder().decode(FriendReferralResponse.self, from: data) else {
                            let JSONString = String(data: data, encoding: String.Encoding.utf8)
                            print(JSONString ?? "Could not print Json")
                            completion(nil, ServiceError.malformedResponse)
                            return
                        }
                        

                        
                        completion(tempObject, nil)
                        
                    }
                    
                case 403:
                    print("403")
                    completion(nil, ServiceError.missingAPIKey)
                case 401:
                    print("401")
                    completion(nil, ServiceError.invalidAPIKey)
                default:
                    print("default")
                    completion(nil, ServiceError.serverError)
                }
            }
        }
        
        task.resume()
        
        
    }

    
    func adaptRequest(urlRequest: inout URLRequest) {
        if NetworkManager.shared().APIKey.count > 0 {
            urlRequest.addValue(NetworkManager.shared().APIKey, forHTTPHeaderField: "APIKey")
            if Localizator.sharedInstance.language == Languages.arabic {
                urlRequest.addValue("ar", forHTTPHeaderField: "lang")

            } else {
                urlRequest.addValue("en", forHTTPHeaderField: "lang")

            }

        }
    }
    
    
    func registerDevice() {
        
    }
    
    
    func registerAPIKey(APIKey: String,language: Languages  = .english) {
        NetworkManager.shared().APIKey = APIKey
        UserDefaults.standard.set(APIKey, forKey: UserDefaultsKeys.APIKey.rawValue)
        setLanguage(language: language)
    }
    func setLanguage(language: Languages) {
        Localizator.sharedInstance.language = language
        NetworkManager.shared().currentLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: UserDefaultsKeys.LanguageKey.rawValue)
    }
    
    func registerPlayer(playerId: String, categoryId: String) {
        NetworkManager.shared().playerId = playerId
        NetworkManager.shared().categoryId = categoryId
        UserDefaults.standard.set(categoryId, forKey: UserDefaultsKeys.playerCategoryId.rawValue)
        UserDefaults.standard.set(playerId, forKey: UserDefaultsKeys.playerId.rawValue)
        self.registerPlayerRequest(playerUniqueId: playerId, playerCategroyId: categoryId) { (response, error) in
            if error != nil {
                // do something
                print("failed to register user because \(error!.description)")
            }
            else {
                print("Player registered using uuid")
            }
        }
    }
    
    
    func friendReferral(withCategroyId: Int = 0) {
        if isDynamicSet(){
        self.friendReferralRequest(withReferralCode: referalCode,playerUniqueId: playerId, playerCategroyId: withCategroyId) { (response, error) in
            if error != nil {
                // do something
                print("failed to register user because \(error!.description)")
            }
            else {
                print(response?.errorMsg ?? "")
            }
        }
        }
    }
    
    func registerDevice(withToken: String) {

        self.registerPlayerRequest(playerUniqueId: playerId, playerCategroyId: categoryId, deviceToken: withToken) { (response, error) in
            if error != nil {
                // do something
                print("failed to register user because \(error!.description)")
            }
            else {
                print("Player registered using uuid")
            }
        }
    }
    
    func setPlayer(playerId: String, categoryId: String) {
        NetworkManager.shared().playerId = playerId
        NetworkManager.shared().categoryId = categoryId
        UserDefaults.standard.set(categoryId, forKey: UserDefaultsKeys.playerCategoryId.rawValue)
        UserDefaults.standard.set(playerId, forKey: UserDefaultsKeys.playerId.rawValue)
    }
    
    
    func deRegisterPlayer() {
        NetworkManager.shared().playerId = ""
        NetworkManager.shared().categoryId = ""
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.playerId.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.playerCategoryId.rawValue)
    }
    
 
    
    
}

extension URL {
    init(path: String, params: JSON , method: RequestMethod) {
        
        var components = URLComponents()
        components.scheme = NetworkManager.shared().connectionScheme
        components.host = NetworkManager.shared().host
//        components.port = NetworkManager.shared().port
        components.path += path
        if params.count > 0 {
            switch method {
            case .GET, .DELETE:
                components.queryItems = params.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
            default:
                break
            }
        }
        print(components.url!)
        self = components.url!
    }
}

extension URLRequest {
    init(path: String, method: RequestMethod = .GET, params: JSON = [:]) {
        let url = URL(path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        switch method {
        case .POST, .PUT:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            setValue("application/json", forHTTPHeaderField: "Content-Type")

        default:
            break
        }
    }
    
}
//set, get & remove User own profile in cache
struct UserProfileCache {
    static let key = "userProfileCache"
    static func save(_ value: PlayerInfo!) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> PlayerInfo! {
        var userData: PlayerInfo!
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(PlayerInfo.self, from: data)
            return userData!
        } else {
            return userData
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
