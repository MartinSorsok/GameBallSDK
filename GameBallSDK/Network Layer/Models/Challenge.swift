//
//  Challenge.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/6/19.
//  Copyright © 2019 Martin Sorsok. All rights reserved.
//

import Foundation

class Challenge: Codable {
    let gameName: String?
    let challengeID: Int?
    let icon: String?
    let description: String?
    let isUnlocked: Bool?
    let activationCriteriaTypeID: Int?
    let activationFrubes: Int?
    let activationLevel: Int?
    let levelName: String?
    let behaviorTypeID: Int?
    let behaviorType: String?
    let targetActionsCount: Int?
    let targetAmount: Int?
    let rewardPoints: Int?
    let rewardFrubies: Int?
    let highScore: Int?
    let highScoreAmount: Int?
    let amountUnit: String?
    let actionsCompletedPercentage: Int?
    let amountCompletedPercentage: Int?
    let completionPercentage:Int?
    let actionsAndAmountCompletedPercentage: Int?
    let isRepeatable : Bool?
    let isReferral: Bool?
    let achievedCount: Int?
    let achievedActionsCount: Int?
    let currentAmount: Int?
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
            return LocalizationsKeys.ChallengeDetails.locked.rawValue.localized
        case .inProgress:
            return LocalizationsKeys.ChallengeDetails.keepGoing.rawValue.localized
        case .achieved:
            return LocalizationsKeys.ChallengeDetails.achieved.rawValue.localized
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
        case completionPercentage = "completionPercentage"
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
