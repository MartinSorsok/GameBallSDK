//
//  FriendReferralResponse.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/18/19.
//

import Foundation


struct FriendReferralResponse: Codable {
    let success: Bool?
    let status: StatusResponse?
    
    enum CodingKeys: String, CodingKey {
        case success = "isSucceeded"
        case status = "status"
    }
}



