//
//  Quest.swift
//  Alamofire
//
//  Created by Ahmed Abodeif on 4/10/19.
//

import Foundation

struct Quest: Codable {
    let questName: String?
    let questID: Int?
    let description: String?
    let isActive, isReferral: Bool?
    let rewardFrubies, rewardPoints: Int?
    let questChallenges: [Challenge]?
    
    enum CodingKeys: String, CodingKey {
        case questName = "questName"
        case questID = "questId"
        case description = "description"
        case isActive = "isActive"
        case isReferral = "isReferral"
        case rewardFrubies = "rewardFrubies"
        case rewardPoints = "rewardPoints"
        case questChallenges = "questChallenges"
    }
}
