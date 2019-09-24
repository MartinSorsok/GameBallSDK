//
//  GetLeaderboardResponse.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct GetLeaderboardResponse: Codable {
    let response: LeaderboardPlayerBot?
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


struct LeaderboardPlayerBot: Codable {
    let playerBot: [Profile]?
    let playerRank: LeaderboardPlayerRank?

    
    
    enum CodingKeys: String, CodingKey {
        case playerBot = "playerBot"
        case playerRank = "playerRank"
    }
}
struct LeaderboardPlayerRank: Codable {
    let rowOrder: Int?
    let frubies: Int?
    let playerUniqueId: Int?
    let playersCount: Int?

    enum CodingKeys: String, CodingKey {
        case rowOrder = "rowOrder"
        case frubies = "frubies"
        case playerUniqueId = "playerUniqueId"
        case playersCount = "playersCount"
    }
}
