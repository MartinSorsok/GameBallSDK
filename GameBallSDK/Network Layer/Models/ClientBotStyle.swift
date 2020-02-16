//
//  ClientBotStyle.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

struct ClientBotStyle: Codable {
//    let clientID: Int
    let botMainColor, buttonBackgroundColor, buttonFlagColor, referralSignUpLink, referralHeadLine, referralText, buttonSariColor: String?
    let buttonShape, buttonDirection, offlineStatemessage, button, buttonLink: String?
    let enableLeaderboard, enableNotifications, enableAchievements, isReferralOn, enableUserProfile, isRankPointsVisible, isWalletPointsVisible: Bool?
    let rankPointsName: String?
    let referralIcon: String?

    let walletPointsName: String?
    enum CodingKeys: String, CodingKey {
//        case clientID = "clientId"
        
        case enableNotifications = "enableNotifications"
        case enableAchievements = "enableAchievements"
        case isReferralOn = "isReferralOn"
        case enableUserProfile = "enableUserProfile"
        case isRankPointsVisible = "isRankPointsVisible"
        case isWalletPointsVisible = "isWalletPointsVisible"

        case botMainColor = "botMainColor"
        case buttonBackgroundColor = "buttonBackgroundColor"
        case buttonFlagColor = "buttonFlagColor"
        case buttonSariColor = "buttonSariColor"
        case buttonShape = "buttonShape"
        case buttonDirection = "buttonDirection"
        case offlineStatemessage = "offlineStatemessage"
        case button = "button"
        case buttonLink = "buttonLink"
        case enableLeaderboard = "enableLeaderboard"
        case referralSignUpLink = "referralSignUpLink"
        case referralHeadLine = "referralHeadLine"
        case referralText = "referralText"
        case rankPointsName = "rankPointsName"
        case walletPointsName = "walletPointsName"
        case referralIcon = "referralIcon"

    }
}
