//
//  MileStone.swift
//  Alamofire
//
//  Created by Ahmed Abodeif on 4/10/19.
//

import Foundation

struct Milestone: Codable {
    let milestoneName: String?
    let milestoneID: Int?
    let description: String?
    let rewardFrubies, rewardPoints: Int?
    let targetAmount: Int?
    let targetActionsCount, achievedCount, actionsCompletedPercentage, amountCompletedPercentage: Double?
    let actionsAndAmountCompletedPercentage: Double?
    let userMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case milestoneName = "MilestoneName"
        case milestoneID = "MilestoneId"
        case description = "Description"
        case rewardFrubies = "RewardFrubies"
        case rewardPoints = "RewardPoints"
        case targetAmount = "TargetAmount"
        case targetActionsCount = "TargetActionsCount"
        case achievedCount = "AchievedCount"
        case actionsCompletedPercentage = "ActionsCompletedPercentage"
        case amountCompletedPercentage = "AmountCompletedPercentage"
        case actionsAndAmountCompletedPercentage = "ActionsAndAmountCompletedPercentage"
        case userMessage = "UserMessage"
    }
}
