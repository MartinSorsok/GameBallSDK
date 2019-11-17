//
//  PostActionResponse.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 2/22/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct PostActionResponse: Codable {
    let response: [String:String]?
    let success: Bool?
    let errorMsg: String?
    let errorCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
        case success = "success"
        case errorMsg = "errorMsg"
        case errorCode = "errorCode"
    }
}


struct StatusResponse: Codable {
    let code: Int?
    let message: String?
 
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
    }
}


struct ActionResult: Codable {
    let id, challengeID: Int?
    let affectedAchievementID: String?
    let playerUniqueId: String?
    let actionTypeID, actionResultPlayerCategoryID: Int?
    let source: String?
    let used, isPositive: Bool?
    let amount, frubies: Int?
    let creationDate, challengeAPIID: String?
    let playerUniqueID: String?
    let clientID: Int?
    let playerTypeId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case challengeID = "ChallengeID"
        case affectedAchievementID = "AffectedAchievementId"
        case playerUniqueId = "playerUniqueId"
        case actionTypeID = "ActionTypeId"
        case actionResultPlayerCategoryID = "playerTypeId"
        case source = "Source"
        case used = "Used"
        case isPositive
        case amount = "Amount"
        case frubies = "Frubies"
        case creationDate = "CreationDate"
        case challengeAPIID = "ChallengeAPIID"
        case playerUniqueID = "PlayerUniqueID"
        case clientID = "ClientID"
        case playerTypeId = "PlayerTypeId"
    }
}
