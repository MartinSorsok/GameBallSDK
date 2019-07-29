//
//  Icon.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/12/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation


struct Icon: Codable {
//    let id : Int?
//    let name: String?
    let fileName: String?
//    let iconTypeID: Int?
//    let creationDate, lastUpdate: String?
    
    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
        case fileName = "fileName"
//        case iconTypeID = "iconTypeId"
//        case creationDate = "creationDate"
//        case lastUpdate = "lastUpdate"
    }
}

