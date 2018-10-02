//
//  DailyWeatherProtocol.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

protocol DailyWeatherProtocol: HourlyWeatherProtocol {
    var sunriseTime: UInt64 { get }
    var sunsetTime: UInt64 { get }
    var moonPhase: Double { get }
    var precipIntensityMax: Double { get }
    var precipIntensityMaxTime : UInt64? { get }
    var temperatureHigh: Double { get }
    var temperatureHighTime: UInt64 { get }
    var temperatureLow: Double { get }
    var temperatureLowTime: UInt64 { get }
    var apparentTemperatureHigh: Double { get }
    var apparentTemperatureHighTime: Double { get }
    var apparentTemperatureLow: Double { get }
    var apparentTemperatureLowTime: Double { get }
    var windGustTime: UInt64 { get }
    var uvIndexTime: UInt64 { get }
    var temperatureMin: Double { get }
    var temperatureMinTime: UInt64 { get }
    var temperatureMax: Double { get }
    var temperatureMaxTime: UInt64 { get }
    var apparentTemperatureMin: Double { get }
    var apparentTemperatureMinTime: UInt64 { get }
    var apparentTemperatureMax: Double { get }
    var apparentTemperatureMaxTime: UInt64 { get }
}
