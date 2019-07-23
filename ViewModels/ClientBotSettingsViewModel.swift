//
//  ClientBotSettingsViewModel.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

class ClientBotSettingsViewModel {
    
    var botStyle: ClientBotStyle?
    var networkRequestInProgess = false
    
    
    func getClientBotStyle(completion: @escaping ((_ error: ServiceError?)->())) {
        self.networkRequestInProgess = true
        NetworkManager.shared().load(path: APIEndPoints.getBotStyle, method: .GET, params: [:], modelType: GetClientBotStyleResponse.self) { (data, error) in
            
            guard let errorModel = error else {
                if data != nil {
                    self.botStyle = (data as? GetClientBotStyleResponse)?.response
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
