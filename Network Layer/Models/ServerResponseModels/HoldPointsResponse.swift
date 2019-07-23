//
//  HoldPointsResponse.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 5/15/19.
//

import Foundation


struct HoldPointsResponse: Codable {
    let response: HoldPointsResponseObject?
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

struct HoldPointsResponseObject: Codable {
    let playerUniqueID: String??
    let transactionTime: String??
    let bodyHashed: String??
    let amount: String??
    let holdReference: String??
    let oTP: String??

    enum CodingKeys: String, CodingKey {
        case playerUniqueID = "PlayerUniqueID"
        case transactionTime = "TransactionTime"
        case bodyHashed = "BodyHashed"
        case amount = "Amount"
        case holdReference = "HoldReference"
        case oTP = "OTP"

    }
}

