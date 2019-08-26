//
//  PlayerInfo.swift
//  Alamofire
//
//  Created by Ahmed Abodeif on 4/7/19.
//

import Foundation



struct PlayerInfo: Codable {
    let displayName, firstName, lastName: String?
    let email, gender: String?
    let mobileNumber: String?
    let dateOfBirth: String?
    let joinDate: String?
    let playerCategoryID, playerId: Int?
    let externalID: String?
    let currentLevel, accFrubies, accPoints: Int?
    let level: Level?
    let referralCode, referredByID: String?
    let isActive: Bool?
    let dynamicLink, dynamicPreviewLink : String?

    enum CodingKeys: String, CodingKey {
        
        case playerId = "id"
        case displayName = "displayName"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case gender = "gender"
        case mobileNumber = "mobileNumber"
        case dateOfBirth = "dateOfBirth"
        case joinDate = "joinDate"
        case playerCategoryID = "playerCategoryId"
        case externalID = "externalId"
        case currentLevel = "currentLevel"
        case accFrubies = "accFrubies"
        case accPoints = "accPoints"
        case isActive = "isActive"
//        case statusID = "statusId"
        case level = "level"
        case referralCode = "referralCode"
        case referredByID = "referredById"
        case dynamicLink = "dynamicLink"
        case dynamicPreviewLink = "dynamicPreviewLink"
    }
}
