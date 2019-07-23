//
//  RewardPointsResponse.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 5/15/19.
//


import Foundation


struct RewardPointsResponse: Codable {
    let response: RewardPointsResponseObject?
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

struct RewardPointsResponseObject: Codable {
    let playerUniqueID: String??
    let transactionTime: String??
    let bodyHashed: String??
    let amount: String??
    let transactionOnClientSystemId: String??

    enum CodingKeys: String, CodingKey {
        case playerUniqueID = "PlayerUniqueID"
        case transactionTime = "TransactionTime"
        case bodyHashed = "BodyHashed"
        case amount = "Amount"
        case transactionOnClientSystemId = "TransactionOnClientSystemId"

    }
}
