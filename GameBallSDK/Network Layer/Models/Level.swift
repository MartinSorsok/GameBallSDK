//
//  Level.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

struct Level: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let rewardFrubies, rewardPoints, levelFrubies, levelOrder: Int?
    let icon: Icon?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case rewardFrubies = "rewardFrubies"
        case rewardPoints = "rewardPoints"
        case levelFrubies = "levelFrubies"
        case levelOrder = "levelOrder"
        case icon = "icon"

//        case iconEnabled = "iconEnabled"
//        case isDeleted, isDefault, isActive
//        case playerCategoryID = "playerCategoryID"
//        case isAchivedNotificationsOn = "isAchivedNotificationsOn"
//        case iconID = "iconID"
    }
}
