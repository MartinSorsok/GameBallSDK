//
//  PlayerProfile.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let name: String?
    let displayName: String?
    let email, gender: String?
    let age: Int?
    let dateOfBirth: String?
    let playerTypeId: Int?
    let playerUniqueId: String?
    let currentLevel, accFrubies, accPoints, statusID: Int?
    let level: Level?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case displayName = "displayName"
        case gender = "gender"
        case age = "age"
        case dateOfBirth = "dateOfBirth"
        case playerTypeId = "playerTypeId"
        case playerUniqueId = "playerUniqueId"
        case currentLevel = "currentLevel"
        case accFrubies = "accFrubies"
        case accPoints = "accPoints"
        case statusID = "statusId"
        case level = "level"
    }
}


