//
//  WetherData.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

class WetherData: Decodable {
    var latitude: Double
    var longitude: Double
    var timezone: String
    var offset: Int
    var currently: CurrentWeather
    var minutely: MinutelyWetherData
    var hourly: HourlyWetherData
    var daily: DailyWetherData
    var flags: Flags
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case offset
        case currently
        case minutely
        case flags
        case daily
        case hourly
    }
}
