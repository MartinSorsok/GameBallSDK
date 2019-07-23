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
        case questName = "QuestName"
        case questID = "QuestId"
        case description = "Description"
        case isActive = "IsActive"
        case isReferral = "IsReferral"
        case rewardFrubies = "RewardFrubies"
        case rewardPoints = "RewardPoints"
        case questChallenges = "QuestChallenges"
    }
}
