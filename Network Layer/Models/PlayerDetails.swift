//
//  PlayerDetails.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct PlayerDetails: Codable {
    let name, email, gender: String?
    let age: Int?
    let dateOfBirth: String?
    let playerCategoryID: Int?
    let externalID: String?
    let currentLevel, accFrubies, accPoints, statusID: Int?
    let level: Level?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case email = "Email"
        case gender = "Gender"
        case age = "Age"
        case dateOfBirth = "DateOfBirth"
        case playerCategoryID = "PlayerCategoryID"
        case externalID = "ExternalID"
        case currentLevel = "CurrentLevel"
        case accFrubies = "AccFrubies"
        case accPoints = "AccPoints"
        case statusID = "StatusId"
        case level = "Level"
    }
}
