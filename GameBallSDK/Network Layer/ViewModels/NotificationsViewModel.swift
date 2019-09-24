//
//  NotificationsViewModel.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 8/15/19.
//


import Foundation


class NotificationsViewModel {
    
    //    var botStyle: ClientBotStyle?
    var notifications: [NotificationGB] = []
    var networkRequestInProgess = false
    
    func getNotifications(completion: @escaping ((_ error: ServiceError?)->())) {
        self.networkRequestInProgess = true
        NetworkManager.shared().load(path: APIEndPoints.getNotifications, method: .GET, params: ["playerUniqueId":NetworkManager.shared().playerUniqueId], modelType: NotificationsResponse.self) { (data, error) in
            
            guard let errorModel = error else {
                if data != nil {
                    self.notifications = (data as? NotificationsResponse)?.response ?? []
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
