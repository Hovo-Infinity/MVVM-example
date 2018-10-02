//
//  SimpleWeatherProtocol.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

protocol SimpleWeatherProtocol {
    var time: UInt64 { get }
    var precipIntensity: Double { get }
    var precipProbability: Double { get }
    var precipType: String? { get }
    var precipIntensityError: Double? { get }
}
