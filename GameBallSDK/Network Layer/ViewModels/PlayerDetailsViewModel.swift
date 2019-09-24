//
//  PlayerDetailsViewModel.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


class PlayerDetailsViewModel {
    
    var playerDetails: PlayerDetails?
    var networkRequestInProgess = false
    
    func getPlayerDetails(completion: @escaping ((_ error: ServiceError?)->())) {
        self.networkRequestInProgess = true
        NetworkManager.shared().load(path: APIEndPoints.getPlayerDetails, method: .GET, params: ["playerUniqueId":NetworkManager.shared().playerUniqueId], modelType: GetPlayerDetailsResponse.self) { (data, error) in
            
            guard let errorModel = error else {
                if data != nil {
                    self.playerDetails = (data as? GetPlayerDetailsResponse)?.playerDetails
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
