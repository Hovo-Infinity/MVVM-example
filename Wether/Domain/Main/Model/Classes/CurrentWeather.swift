//
//  CurrentWeather.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

class CurrentWeather: HourlyWeatherProtocol, Decodable {
    var summary: String
    
    var icon: String
    
    var temperature: Double
    
    var apparentTemperature: Double
    
    var dewPoint: Double
    
    var humidity: Double
    
    var pressure: Double
    
    var windSpeed: Double
    
    var windGust: Double
    
    var windBearing: Double
    
    var cloudCover: Double
    
    var uvIndex: Double
    
    var visibility: Double
    
    var ozone: Double
    
    var time: UInt64
    
    var precipIntensity: Double
    
    var precipProbability: Double
    
    var precipType: String?
    
    var precipIntensityError: Double?
    
    var nearestStormDistance: Int
    
    enum CodingKeys: String, CodingKey {
        case summary
        
        case icon
        
        case temperature
        
        case apparentTemperature
        
        case dewPoint
        
        case humidity
        
        case pressure
        
        case windSpeed
        
        case windGust
        
        case windBearing
        
        case cloudCover
        
        case uvIndex
        
        case visibility
        
        case ozone
        
        case time
        
        case precipIntensity
        
        case precipProbability
        
        case precipType
        
        case precipIntensityError
        
        case nearestStormDistance
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        summary = try container.decodeIfPresent(String.self, forKey: .summary)!
        
        icon = try container.decodeIfPresent(String.self, forKey: .icon)!
        
        temperature = try container.decodeIfPresent(Double.self, forKey: .temperature)!
        
        apparentTemperature = try container.decodeIfPresent(Double.self, forKey: .apparentTemperature)!
        
        dewPoint = try container.decodeIfPresent(Double.self, forKey: .dewPoint)!
        
        humidity = try container.decodeIfPresent(Double.self, forKey: .humidity)!
        
        pressure = try container.decodeIfPresent(Double.self, forKey: .pressure)!
        
        windSpeed = try container.decodeIfPresent(Double.self, forKey: .windSpeed)!
        
        windGust = try container.decodeIfPresent(Double.self, forKey: .windGust)!
        
        windBearing = try container.decodeIfPresent(Double.self, forKey: .windBearing)!
        
        cloudCover = try container.decodeIfPresent(Double.self, forKey: .cloudCover)!
        
        uvIndex = try container.decodeIfPresent(Double.self, forKey: .uvIndex)!
        
        visibility = try container.decodeIfPresent(Double.self, forKey: .visibility)!
        
        ozone = try container.decodeIfPresent(Double.self, forKey: .ozone)!
        
        time = try container.decodeIfPresent(UInt64.self, forKey: .time)!
        
        precipIntensity = try container.decodeIfPresent(Double.self, forKey: .precipIntensity)!
        
        precipProbability = try container.decodeIfPresent(Double.self, forKey: .precipProbability)!
        
        precipType = try container.decodeIfPresent(String.self, forKey: .precipType)
        
        precipIntensityError = try container.decodeIfPresent(Double.self, forKey: .precipIntensityError)
        
        nearestStormDistance = try container.decodeIfPresent(Int.self, forKey: .nearestStormDistance)!
    }
}

