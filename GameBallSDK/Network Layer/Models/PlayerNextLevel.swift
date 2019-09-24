//
//  PlayerNextLevel.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct PlayerNextLevel: Codable {
    let clientID: Int?
    let isAchivedNotificationsOn: Bool?
    let iconID, name: String?
    let description: String?
    let rewardFrubies, rewardPoints, levelFrubies, levelOrder: Int?
    let iconEnabled, isDeleted, isDefault, isActive: Bool?
    let playerTypeId: Int?
    let icon: Icon?
    
    enum CodingKeys: String, CodingKey {
        case clientID = "clientID"
        case isAchivedNotificationsOn = "isAchivedNotificationsOn"
        case iconID = "iconID"
        case name = "name"
        case description = "description"
        case rewardFrubies = "rewardFrubies"
        case rewardPoints = "rewardPoints"
        case levelFrubies = "levelFrubies"
        case levelOrder = "levelOrder"
        case iconEnabled = "iconEnabled"
        case isDeleted, isDefault, isActive
        case playerTypeId = "playerTypeId"
        case icon = "icon"
    }
}
