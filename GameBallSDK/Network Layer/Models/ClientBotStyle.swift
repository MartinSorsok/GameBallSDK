//
//  ClientBotStyle.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

struct ClientBotStyle: Codable {
    let clientID: Int
    let botMainColor, buttonBackgroundColor, buttonFlagColor, buttonSariColor: String
    let shape, direction, offlineStatemessage, button, buttonLink: String?
    let enableLeaderboard: Bool?
    enum CodingKeys: String, CodingKey {
        case clientID = "ClientId"
        case botMainColor = "BotMainColor"
        case buttonBackgroundColor = "ButtonBackgroundColor"
        case buttonFlagColor = "ButtonFlagColor"
        case buttonSariColor = "ButtonSariColor"
        case shape = "Shape"
        case direction = "Direction"
        case offlineStatemessage = "OfflineStatemessage"
        case button = "Button"
        case buttonLink = "ButtonLink"
        case enableLeaderboard = "EnableLeaderboard"
    }
}
