//
//  GetPlayerDetails.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

struct GetPlayerDetailsResponse: Codable {
    let playerDetails: PlayerDetails?
    let success: Bool?
    let errorMsg: String?
    let errorCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case playerDetails = "response"
        case success = "success"
        case errorMsg = "rrrorMsg"
        case errorCode = "rrrorCode"
    }
}
