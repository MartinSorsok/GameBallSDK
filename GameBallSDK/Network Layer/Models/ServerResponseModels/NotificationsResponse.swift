//
//  NotificationsResponse.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 8/15/19.
//

import Foundation


struct NotificationsResponse: Codable {
    let response: [NotificationGB]?
    let success: Bool?
    let errorMsg: String?
    let errorCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case response
        case success = "success"
        case errorMsg = "errorMsg"
        case errorCode = "errorCode"
    }
}
