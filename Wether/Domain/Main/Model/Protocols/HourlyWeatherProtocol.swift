//
//  HourlyWeatherProtocol.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

protocol HourlyWeatherProtocol: SimpleWeatherProtocol {
    var summary: String { get }
    var icon: String { get }
    var temperature: Double? { get }
    var apparentTemperature: Double? { get }
    var dewPoint: Double { get }
    var humidity: Double { get }
    var pressure: Double { get }
    var windSpeed: Double { get }
    var windGust : Double { get }
    var windBearing: Double { get }
    var cloudCover: Double { get }
    var uvIndex: Double { get }
    var visibility: Double { get }
    var ozone: Double { get }
}
