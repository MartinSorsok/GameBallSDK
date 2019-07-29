//
//  Challenge.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/6/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

class Challenge: Codable {
    let gameName: String?
    let challengeID: Int?
    let icon: String?
    let description: String?
    let isUnlocked: Bool?
    let activationCriteriaTypeID: Int?
    let activationFrubes, activationLevel: Int?
    let levelName: String?
    let behaviorTypeID: Int?
    let behaviorType: String?
    let targetActionsCount, targetAmount, rewardPoints: Int?
    let rewardFrubies: Int?
    let highScore: Int?
    let highScoreAmount: String?
    let amountUnit: String?
    let actionsCompletedPercentage, amountCompletedPercentage, actionsAndAmountCompletedPercentage: Float?
    let isRepeatable, isReferral: Bool?
    let achievedCount, achievedActionsCount, currentAmount: Int?
    let userMessage: String?
    let milestones: [Milestone]?
    
    var status: ChallengeStatus {
        guard let isUnlocked = isUnlocked, let achievedCount = achievedCount else {
            return .locked
        }
        if !isUnlocked {
            return .locked
        }
        else if achievedCount > 0 {
            return .achieved
        }
        else {
            return .inProgress
        }
    }
    
    var statusDescription: String {
        switch status {
        case .locked:
            return "Locked! You need to be on level “Level Name Here” to unlock this badge"
        case .inProgress:
            return "Keep going! Earn this badge and claim your prize "
        case .achieved:
            return "Achieved (1)"
        }
    }
    
    var challengeType: ChallengeType {
        let behaviour = behaviorTypeID ?? 0
        switch behaviour {
        case 0:
            return .unkown
        case 1:
            return .AmountBased
        case 2:
            return .ActionBased
        case 3:
            return .ActionAndAmountBased
        case 4:
            return .Highscore
        default:
            return .unkown
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case gameName = "gameName"
        case challengeID = "challengeId"
        case icon = "icon"
        case description = "description"
        case isUnlocked = "isUnlocked"
        case activationCriteriaTypeID = "activationCriteriaTypeId"
        case activationFrubes = "activationFrubes"
        case activationLevel = "activationLevel"
        case levelName = "levelName"
        case behaviorTypeID = "behaviorTypeId"
        case behaviorType = "behaviorType"
        case targetActionsCount = "targetActionsCount"
        case targetAmount = "targetAmount"
        case rewardPoints = "rewardPoints"
        case rewardFrubies = "rewardFrubies"
        case highScore = "highScore"
        case highScoreAmount = "highScoreAmount"
        case amountUnit = "amountUnit"
        case actionsCompletedPercentage = "actionsCompletedPercentage"
        case amountCompletedPercentage = "amountCompletedPercentage"
        case actionsAndAmountCompletedPercentage = "actionsAndAmountCompletedPercentage"
        case isRepeatable = "isRepeatable"
        case isReferral = "isReferral"
        case achievedCount = "achievedCount"
        case achievedActionsCount = "achievedActionsCount"
        case currentAmount = "currentAmount"
        case userMessage = "userMessage"
        case milestones = "milestones"
    }
}

enum ChallengeStatus {
    case locked
    case inProgress
    case achieved
}

enum ChallengeType {
    case AmountBased
    case ActionBased
    case ActionAndAmountBased
    case Highscore
    case unkown
}
