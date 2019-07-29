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
        case response = "response"
        case success = "success"
        case errorMsg = "errorMsg"
        case errorCode = "errorCode"
    }
}

struct GetPlayerInfoResponseObject: Codable {
    let playerInfo: PlayerInfo?
    let nextLevel: Level?
    
    enum CodingKeys: String, CodingKey {
        case playerInfo = "playerInfo"
        case nextLevel = "nextLevel"
    }
}
