//
//  Flags.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

class Flags: Decodable {
    var sources: [String]
    var nearestStation: Double
    var units: String
    
    enum CodingKeys: String, CodingKey {
        case nearestStation = "nearest-station"
        case sources
        case units
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        units = try container.decodeIfPresent(String.self, forKey: .units)!
        nearestStation = try container.decodeIfPresent(Double.self, forKey: .nearestStation)!
        sources = try container.decodeIfPresent([String].self, forKey: .sources)!
    }
}
