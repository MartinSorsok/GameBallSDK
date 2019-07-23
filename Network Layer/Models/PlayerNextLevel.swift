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
    let playerCategoryID: Int?
    let icon: Icon?
    
    enum CodingKeys: String, CodingKey {
        case clientID = "ClientID"
        case isAchivedNotificationsOn = "IsAchivedNotificationsOn"
        case iconID = "IconID"
        case name = "Name"
        case description = "Description"
        case rewardFrubies = "RewardFrubies"
        case rewardPoints = "RewardPoints"
        case levelFrubies = "LevelFrubies"
        case levelOrder = "LevelOrder"
        case iconEnabled = "IconEnabled"
        case isDeleted, isDefault, isActive
        case playerCategoryID = "PlayerCategoryID"
        case icon = "Icon"
    }
}
