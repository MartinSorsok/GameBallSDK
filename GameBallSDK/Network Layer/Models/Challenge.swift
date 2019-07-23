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
        case gameName = "GameName"
        case challengeID = "ChallengeId"
        case icon = "Icon"
        case description = "Description"
        case isUnlocked = "IsUnlocked"
        case activationCriteriaTypeID = "ActivationCriteriaTypeId"
        case activationFrubes = "ActivationFrubes"
        case activationLevel = "ActivationLevel"
        case levelName = "LevelName"
        case behaviorTypeID = "BehaviorTypeId"
        case behaviorType = "BehaviorType"
        case targetActionsCount = "TargetActionsCount"
        case targetAmount = "TargetAmount"
        case rewardPoints = "RewardPoints"
        case rewardFrubies = "RewardFrubies"
        case highScore = "HighScore"
        case highScoreAmount = "HighScoreAmount"
        case amountUnit = "AmountUnit"
        case actionsCompletedPercentage = "ActionsCompletedPercentage"
        case amountCompletedPercentage = "AmountCompletedPercentage"
        case actionsAndAmountCompletedPercentage = "ActionsAndAmountCompletedPercentage"
        case isRepeatable = "IsRepeatable"
        case isReferral = "IsReferral"
        case achievedCount = "AchievedCount"
        case achievedActionsCount = "AchievedActionsCount"
        case currentAmount = "CurrentAmount"
        case userMessage = "UserMessage"
        case milestones = "Milestones"
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
