//
//  Notification.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 8/15/19.
//

import Foundation

struct NotificationGB: Codable {
    let id: Int?
    let titleApp: String?
    let bodyApp: String?
    let dateTime: String?
    let languageCode: String?
    let iconPath: String?
    let isRead: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case titleApp = "titleApp"
        case bodyApp = "bodyApp"
        case dateTime = "dateTime"
        case languageCode = "languageCode"
        case iconPath = "iconPath"
        case isRead = "isRead"
    }
}
