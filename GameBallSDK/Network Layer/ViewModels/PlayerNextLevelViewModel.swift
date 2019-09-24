//
//  PlayerNextLevelViewModel.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


class PlayerNextLevelViewModel {
    
    //    var botStyle: ClientBotStyle?
    var playerNextLevel: PlayerNextLevel?
    var networkRequestInProgess = false
    
    func getLeaderboard(completion: @escaping ((_ error: ServiceError?)->())) {
        self.networkRequestInProgess = true
        NetworkManager.shared().load(path: APIEndPoints.getPlayerNextLevel, method: .GET, params: ["playerUniqueId":NetworkManager.shared().playerUniqueId], modelType: GetPlayerNextLevelResponse.self) { (data, error) in
            
            guard let errorModel = error else {
                if data != nil {
                    self.playerNextLevel = (data as? GetPlayerNextLevelResponse)?.playerNextLevel
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
