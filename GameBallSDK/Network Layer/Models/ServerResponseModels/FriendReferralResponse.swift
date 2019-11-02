//
//  FriendReferralResponse.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/18/19.
//

import Foundation


struct FriendReferralResponse: Codable {
    let success: Bool?
    let response: Bool?
    let errorMsg: String?
    let errorCode: Int?
    enum CodingKeys: String, CodingKey {
        case success
        case response
        case errorMsg
        case errorCode
    }
}



