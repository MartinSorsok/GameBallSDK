//
//  GetPlayerNextLevelResponse.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct GetPlayerNextLevelResponse: Codable {
    let playerNextLevel: PlayerNextLevel?
    let success: Bool?
    let errorMsg: String?
    let errorCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case playerNextLevel = "response"
        case success = "success"
        case errorMsg = "errorMsg"
        case errorCode = "errorCode"
    }
}
