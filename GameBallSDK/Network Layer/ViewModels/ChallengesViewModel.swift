//
//  ChallengesViewModel.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


class ChallengesViewModel {
    
    var challenges: [Challenge] = []
    var quests: [Quest] = []
    var networkRequestInProgess = false
    
    
    func getAllChallenges( completion: @escaping ((_ error: ServiceError?)->())) {
        self.networkRequestInProgess = true
        NetworkManager.shared().load(path: APIEndPoints.getChallengesWithUnlocks, method: .GET, params: ["playerUniqueId":NetworkManager.shared().playerUniqueId], modelType: GetChallengeWithUnlocksResponseModel.self) { (data, error) in
            if let errorModel = error {
                 Helpers().dPrint(errorModel.description)
                completion(errorModel)
                self.networkRequestInProgess = false
                return
            }
            if data != nil {
                self.challenges = (data as! GetChallengeWithUnlocksResponseModel).response?.challenges ?? []
                self.quests = (data as! GetChallengeWithUnlocksResponseModel).response?.quests ?? []
//                let quests = (data as! GetChallengeWithUnlocksResponseModel).response?.quests ?? []
//                let questsWithChalleneges = quests.filter({ $0.questChallenges?.count ?? 0 > 0})
//                self.quests = questsWithChalleneges
                self.networkRequestInProgess = false
                completion(nil)
            }
        }
    }
    
    
    func onSuccess() {
        self.networkRequestInProgess = false
    }
    
    func onFailure() {
        self.networkRequestInProgess = false
    }
    
}
