//
//  MinutelyCellViewModel.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/3/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

class MinutelyCellViewModel {
    
    private var minutelyWeatherModel: MinutelyWeather
    
    init(model: MinutelyWeather) {
        minutelyWeatherModel = model
    }
    
    func getTime() -> String {
        let date = Date(timeIntervalSinceNow: TimeInterval(minutelyWeatherModel.time))
        return DateFormatter().string(from: date)
    }
    
    func getPrecipIntensity() -> String {
        return minutelyWeatherModel.precipIntensity.description
    }
    
}
