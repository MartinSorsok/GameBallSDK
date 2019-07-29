//
//  FriendReferralResponse.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/18/19.
//

import Foundation


struct FriendReferralResponse: Codable {
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


