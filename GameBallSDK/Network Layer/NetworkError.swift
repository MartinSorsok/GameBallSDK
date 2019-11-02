//
//  NetworkError.swift
//  gameball_SDK
//
//  Created by Martin Sorsok on 2/3/19.
//  Copyright © 2019 Martin Sorsok. All rights reserved.
//

import Foundation


enum ServiceError: Error {
    case noInternetConnection
    case serverError
    case custom(String)
    case badImageURL(String)
    case other
    case malformedResponse
    case missingAPIKey
    case invalidAPIKey
}


extension ServiceError {
    
    var description: String {
        switch self {
        case .noInternetConnection:
            return "You are not connected to the internet"
        case .serverError:
            return "Something went wrong, please try again later"
        case .custom(let message):
            return message
        case .badImageURL(let message):
            return message
        case .malformedResponse:
            return "Could not parse response"
        case .missingAPIKey:
            return "Client API key is missing"
        case .invalidAPIKey:
            return "Client API key is inavlid"
            
        case .other:
            return "An unkown error occured"
        }
    }
    
    init(json: [String: Any]) {
        if let message = json["ErrorMsg"] as? String {
            self = .custom(message)
        }
        else {
            self = .other
        }
    }
}
