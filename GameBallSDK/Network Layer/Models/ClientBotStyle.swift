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
    let enableLeaderboard: Bool?
    let rankPointsName: String?
    let walletPointsName: String?
    enum CodingKeys: String, CodingKey {
//        case clientID = "clientId"
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
    }
}
