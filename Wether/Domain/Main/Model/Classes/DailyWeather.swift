//
//  DailyWeather.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

class DailyWeather: DailyWeatherProtocol, Decodable {
    var sunriseTime: UInt64
    
    var sunsetTime: UInt64
    
    var moonPhase: Double
    
    var precipIntensityMax: Double
    
    var precipIntensityMaxTime: UInt64?
    
    var temperatureHigh: Double
    
    var temperatureHighTime: UInt64
    
    var temperatureLow: Double
    
    var temperatureLowTime: UInt64
    
    var apparentTemperatureHigh: Double
    
    var apparentTemperatureHighTime: Double
    
    var apparentTemperatureLow: Double
    
    var apparentTemperatureLowTime: Double
    
    var windGustTime: UInt64
    
    var windBearing: Double
    
    var uvIndexTime: UInt64
    
    var temperatureMin: Double
    
    var temperatureMinTime: UInt64
    
    var temperatureMax: Double
    
    var temperatureMaxTime: UInt64
    
    var apparentTemperatureMin: Double
    
    var apparentTemperatureMinTime: UInt64
    
    var apparentTemperatureMax: Double
    
    var apparentTemperatureMaxTime: UInt64
    
    var summary: String
    
    var icon: String
    
    var temperature: Double?
    
    var apparentTemperature: Double?
    
    var dewPoint: Double
    
    var humidity: Double
    
    var pressure: Double
    
    var windSpeed: Double
    
    var windGust: Double
        
    var cloudCover: Double
    
    var uvIndex: Double
    
    var visibility: Double
    
    var ozone: Double
    
    var time: UInt64
    
    var precipIntensity: Double
    
    var precipProbability: Double
    
    var precipType: String?
    
    var precipIntensityError: Double?
    
    enum CodingKeys: String, CodingKey {
        case sunriseTime
        
        case sunsetTime
        
        case moonPhase
        
        case precipIntensityMax
        
        case precipIntensityMaxTime
        
        case temperatureHigh
        
        case temperatureHighTime
        
        case temperatureLow
        
        case temperatureLowTime
        
        case apparentTemperatureHigh
        
        case apparentTemperatureHighTime
        
        case apparentTemperatureLow
        
        case apparentTemperatureLowTime
        
        case windGustTime
        
        case windBearing
        
        case uvIndexTime
        
        case temperatureMin
        
        case temperatureMinTime
        
        case temperatureMax
        
        case temperatureMaxTime
        
        case apparentTemperatureMin
        
        case apparentTemperatureMinTime
        
        case apparentTemperatureMax
        
        case apparentTemperatureMaxTime
        
        case summary
        
        case icon
        
        case temperature
        
        case apparentTemperature
        
        case dewPoint
        
        case humidity
        
        case pressure
        
        case windSpeed
        
        case windGust
        
        case cloudCover
        
        case uvIndex
        
        case visibility
        
        case ozone
        
        case time
        
        case precipIntensity
        
        case precipProbability
        
        case precipType
        
        case precipIntensityError
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sunriseTime = try container.decodeIfPresent(UInt64.self, forKey: .sunriseTime)!
        
        sunsetTime = try container.decodeIfPresent(UInt64.self, forKey: .sunsetTime)!
        
        moonPhase = try container.decodeIfPresent(Double.self, forKey: .moonPhase)!
        
        precipIntensityMax = try container.decodeIfPresent(Double.self, forKey: .precipIntensityMax)!
        
        precipIntensityMaxTime = try container.decodeIfPresent(UInt64.self, forKey: .precipIntensityMaxTime)
        
        temperatureHigh = try container.decodeIfPresent(Double.self, forKey: .temperatureHigh)!
        
        temperatureHighTime = try container.decodeIfPresent(UInt64.self, forKey: .temperatureHighTime)!
        
        temperatureLow = try container.decodeIfPresent(Double.self, forKey: .temperatureLow)!
        
        temperatureLowTime = try container.decodeIfPresent(UInt64.self, forKey: .temperatureLowTime)!
        
        apparentTemperatureHigh = try container.decodeIfPresent(Double.self, forKey: .apparentTemperatureHigh)!
        
        apparentTemperatureHighTime = try container.decodeIfPresent(Double.self, forKey: .apparentTemperatureHighTime)!
        
        apparentTemperatureLow = try container.decodeIfPresent(Double.self, forKey: .apparentTemperatureLow)!
        
        apparentTemperatureLowTime = try container.decodeIfPresent(Double.self, forKey: .apparentTemperatureLowTime)!
        
        windGustTime = try container.decodeIfPresent(UInt64.self, forKey: .windGustTime)!
        
        windBearing = try container.decodeIfPresent(Double.self, forKey: .windBearing)!
        
        uvIndexTime = try container.decodeIfPresent(UInt64.self, forKey: .uvIndexTime)!
        
        temperatureMin = try container.decodeIfPresent(Double.self, forKey: .temperatureMin)!
        
        temperatureMinTime = try container.decodeIfPresent(UInt64.self, forKey: .temperatureMinTime)!
        
        temperatureMax = try container.decodeIfPresent(Double.self, forKey: .temperatureMax)!
        
        temperatureMaxTime = try container.decodeIfPresent(UInt64.self, forKey: .temperatureMaxTime)!
        
        apparentTemperatureMin = try container.decodeIfPresent(Double.self, forKey: .apparentTemperatureMin)!
        
        apparentTemperatureMinTime = try container.decodeIfPresent(UInt64.self, forKey: .apparentTemperatureMinTime)!
        
        apparentTemperatureMax = try container.decodeIfPresent(Double.self, forKey: .apparentTemperatureMax)!
        
        apparentTemperatureMaxTime = try container.decodeIfPresent(UInt64.self, forKey: .apparentTemperatureMaxTime)!
        
        summary = try container.decodeIfPresent(String.self, forKey: .summary)!
        
        icon = try container.decodeIfPresent(String.self, forKey: .icon)!
        
        temperature = try container.decodeIfPresent(Double.self, forKey: .temperature)
        
        apparentTemperature = try container.decodeIfPresent(Double.self, forKey: .apparentTemperature)
        
        dewPoint = try container.decodeIfPresent(Double.self, forKey: .dewPoint)!
        
        humidity = try container.decodeIfPresent(Double.self, forKey: .humidity)!
        
        pressure = try container.decodeIfPresent(Double.self, forKey: .pressure)!
        
        windSpeed = try container.decodeIfPresent(Double.self, forKey: .windSpeed)!
        
        windGust = try container.decodeIfPresent(Double.self, forKey: .windGust)!
        
        cloudCover = try container.decodeIfPresent(Double.self, forKey: .cloudCover)!
        
        uvIndex = try container.decodeIfPresent(Double.self, forKey: .uvIndex)!
        
        visibility = try container.decodeIfPresent(Double.self, forKey: .visibility)!
        
        ozone = try container.decodeIfPresent(Double.self, forKey: .ozone)!
        
        time = try container.decodeIfPresent(UInt64.self, forKey: .time)!
        
        precipIntensity = try container.decodeIfPresent(Double.self, forKey: .precipIntensity)!
        
        precipProbability = try container.decodeIfPresent(Double.self, forKey: .precipProbability)!
        
        precipType = try container.decodeIfPresent(String.self, forKey: .precipType)
        
        precipIntensityError = try container.decodeIfPresent(Double.self, forKey: .precipIntensityError)
    }
}
