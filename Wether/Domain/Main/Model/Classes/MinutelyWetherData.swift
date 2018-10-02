//
//  MinutelyWetherData.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

class MinutelyWetherData: SimpleTimelyWetherProtocol, Decodable {
    var summary: String
    
    var icon: String
    
    var data: [MinutelyWeather]
    
    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        summary = try container.decodeIfPresent(String.self, forKey: .summary)!
        icon = try container.decodeIfPresent(String.self, forKey: .icon)!
        data = try container.decodeIfPresent([MinutelyWeather].self, forKey: .data)!
    }
    
    
}
