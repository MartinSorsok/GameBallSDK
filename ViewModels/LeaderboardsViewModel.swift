//
//  LeaderboardsViewModel.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


class LeaderboardViewModel {
    
//    var botStyle: ClientBotStyle?
    var leaderboard: [Profile] = []
    var networkRequestInProgess = false
    
    func getLeaderboard(completion: @escaping ((_ error: ServiceError?)->())) {
        self.networkRequestInProgess = true
        NetworkManager.shared().load(path: APIEndPoints.getLeaderboards, method: .GET, params: [:], modelType: GetLeaderboardResponse.self) { (data, error) in

            guard let errorModel = error else {
                if data != nil {
                    self.leaderboard = (data as? GetLeaderboardResponse)?.leaderboard ?? []
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
