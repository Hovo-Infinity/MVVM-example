//
//  MinutelyWeather.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

class MinutelyWeather: SimpleWeatherProtocol, Decodable {
    var time: UInt64
    
    var precipIntensity: Double
    
    var precipProbability: Double
    
    var precipType: String?
    
    var precipIntensityError: Double?
    
    enum CodingKeys: String, CodingKey {
        case time
        
        case precipIntensity
        
        case precipProbability
        
        case precipType
        
        case precipIntensityError
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        time = try container.decodeIfPresent(UInt64.self, forKey: .time)!
        
        precipIntensity = try container.decodeIfPresent(Double.self, forKey: .precipIntensity)!
        
        precipProbability = try container.decodeIfPresent(Double.self, forKey: .precipProbability)!
        
        precipType = try container.decodeIfPresent(String.self, forKey: .precipType)
        
        precipIntensityError = try container.decodeIfPresent(Double.self, forKey: .precipIntensityError)
    }
}
