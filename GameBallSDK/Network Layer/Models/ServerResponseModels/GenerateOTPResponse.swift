//
//  GenerateOTPResponse.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 5/14/19.
//

import Foundation


struct GenerateOTPResponse: Codable {
    let response: GenerateOTPResponseObject?
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

struct GenerateOTPResponseObject: Codable {
    let playerUniqueID: String??
    let transactionTime: String??
    let bodyHashed: String??

    enum CodingKeys: String, CodingKey {
        case playerUniqueID = "PlayerUniqueID"
        case transactionTime = "TransactionTime"
        case bodyHashed = "BodyHashed"

    }
}
