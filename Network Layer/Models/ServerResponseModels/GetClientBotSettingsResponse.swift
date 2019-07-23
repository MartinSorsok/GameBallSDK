//
//  GetClientBotSettings.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/9/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//


import Foundation

struct GetClientBotStyleResponse: Codable {
    let response: ClientBotStyle
    let success: Bool
    let errorMsg: String?
    let errorCode: Int
    
    enum CodingKeys: String, CodingKey {
        case response
        case success = "Success"
        case errorMsg = "ErrorMsg"
        case errorCode = "ErrorCode"
    }
}


