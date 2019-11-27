//
//  Challenge.swift
//  gameball_SDK
//
//  Created by Martin Sorsok on 1/8/19.
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
    let actionsCompletedPercentage: Float?
    let amountCompletedPercentage: Float?
    let completionPercentage:Float?
    let actionsAndAmountCompletedPercentage: Float?
    let isRepeatable : Bool?
    let isReferral: Bool?
    let isActive: Bool?
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
            return GB_LocalizationsKeys.ChallengeDetails.locked.rawValue.localized
        case .inProgress:
            return GB_LocalizationsKeys.ChallengeDetails.keepGoing.rawValue.localized
        case .achieved:
            return GB_LocalizationsKeys.ChallengeDetails.achieved.rawValue.localized
        }
    }
    
    var challengeType: ChallengeType {
        let behaviour = behaviorTypeID ?? 0

        switch behaviour {
        case 0:
            return .unkown
        case 9:
            if isReferral ?? false {
                return .FriendReferal
            }
            return .EventBased
        case 5:
            return .SignUP
        case 7:
            return .Birthday
        case 4:
            return .Highscore
        case 8:
            return .Anniversary
        default:
            return .unkown
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case gameName = "gameName"
        case challengeID = "challengeId"
        case icon = "icon"
        case isActive = "isActive"
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
    case SignUP
    case EventBased
    case Highscore
    case Anniversary
    case Birthday
    case FriendReferal

    case unkown
}
