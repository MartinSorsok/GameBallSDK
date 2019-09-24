//
//  PlayerInfoViewModel.swift
//  Alamofire
//
//  Created by Ahmed Abodeif on 4/7/19.
//

import UIKit


class PlayerInfoViewModel: NSObject {

    var playerAttributes: PlayerInfo?
    var nextLevel: Level?
    var networkRequestInProgess = false
    
    func getPlayerInfo(completion: @escaping ((_ error: ServiceError?)->())) {
        self.networkRequestInProgess = true
        NetworkManager.shared().load(path: APIEndPoints.getPlayerInfo, method: .GET, params: ["playerUniqueId":NetworkManager.shared().playerUniqueId], modelType: GetPlayerInfoResponse.self) { (data, error) in
            
            guard let errorModel = error else {
                if data != nil {
                    self.playerAttributes = (data as? GetPlayerInfoResponse)?.response?.playerInfo
                    self.nextLevel = (data as? GetPlayerInfoResponse)?.response?.nextLevel
                }
                self.networkRequestInProgess = false
                completion(nil)
                return
            }
            completion(errorModel)
            self.networkRequestInProgess = false
        }
    }
    
    func onSuccess() {
        self.networkRequestInProgess = false
    }
    
    func onFailure() {
        self.networkRequestInProgess = false
    }
    
}
