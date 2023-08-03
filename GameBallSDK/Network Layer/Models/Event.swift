//
//  Event.swift
//  GameBallSDK
//
//  Created by Mah on 02/08/2023.
//

import Foundation

public class Event: Codable {
    let name: String
    let params: [String: String]
    
    public init(eventName: String, params: [String : String]) {
        self.name = eventName
        self.params = params
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .eventName)
        params = try container.decode([String: String].self, forKey: .params)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .eventName)
        try container.encode(params, forKey: .params)
    }
    
    private enum CodingKeys: String, CodingKey {
        case eventName
        case params
    }
}
