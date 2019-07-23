//
//  GetPlayerInfoResponse.swift
//  Alamofire
//
//  Created by Ahmed Abodeif on 4/7/19.
//

import Foundation


struct GetPlayerInfoResponse: Codable {
    let response: GetPlayerInfoResponseObject?
    let success: Bool?
    let errorMsg: String?
    let errorCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case response
        case success = "Success"
        case errorMsg = "ErrorMsg"
        case errorCode = "ErrorCode"
    }
}

struct GetPlayerInfoResponseObject: Codable {
    let playerInfo: PlayerInfo?
    let nextLevel: Level?
    
    enum CodingKeys: String, CodingKey {
        case playerInfo = "PlayerInfo"
        case nextLevel = "NextLevel"
    }
}
