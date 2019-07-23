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
    let playerCategoryID: Int?
    let externalID: String?
    let currentLevel, accFrubies, accPoints, statusID: Int?
    let level: Level?
    let referralCode, referredByID: String?
    
    enum CodingKeys: String, CodingKey {
        case displayName = "DisplayName"
        case firstName = "FirstName"
        case lastName = "LastName"
        case email = "Email"
        case gender = "Gender"
        case mobileNumber = "MobileNumber"
        case dateOfBirth = "DateOfBirth"
        case joinDate = "JoinDate"
        case playerCategoryID = "PlayerCategoryID"
        case externalID = "ExternalID"
        case currentLevel = "CurrentLevel"
        case accFrubies = "AccFrubies"
        case accPoints = "AccPoints"
        case statusID = "StatusId"
        case level = "Level"
        case referralCode = "ReferralCode"
        case referredByID = "ReferredById"
    }
}
