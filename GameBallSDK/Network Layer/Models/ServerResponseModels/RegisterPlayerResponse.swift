//
//  RegisterPlayerResponse.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/10/19.
//

import Foundation


struct RegisterPlayerResponse: Codable {
    let response: PlayerInfo?
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


