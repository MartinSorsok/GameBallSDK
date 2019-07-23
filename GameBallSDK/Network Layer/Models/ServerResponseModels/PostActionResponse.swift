//
//  PostActionResponse.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 2/22/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct PostActionResponse: Codable {
    let actionResult: ActionResult?
    let success: Bool?
    let errorMsg: String?
    let errorCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case actionResult = "ActionResult"
        case success = "Success"
        case errorMsg = "ErrorMsg"
        case errorCode = "ErrorCode"
    }
}

struct ActionResult: Codable {
    let id, challengeID: Int?
    let affectedAchievementID: String?
    let playerID: String?
    let actionTypeID, actionResultPlayerCategoryID: Int?
    let source: String?
    let used, isPositive: Bool?
    let amount, frubies: Int?
    let creationDate, challengeAPIID: String?
    let playerUniqueID: String?
    let clientID: Int?
    let playerCategoryID: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case challengeID = "ChallengeID"
        case affectedAchievementID = "AffectedAchievementId"
        case playerID = "PlayerID"
        case actionTypeID = "ActionTypeId"
        case actionResultPlayerCategoryID = "PlayerCategoryId"
        case source = "Source"
        case used = "Used"
        case isPositive
        case amount = "Amount"
        case frubies = "Frubies"
        case creationDate = "CreationDate"
        case challengeAPIID = "ChallengeAPIID"
        case playerUniqueID = "PlayerUniqueID"
        case clientID = "ClientID"
        case playerCategoryID = "PlayerCategoryID"
    }
}
