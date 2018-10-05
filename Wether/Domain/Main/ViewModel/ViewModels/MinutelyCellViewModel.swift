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
        let date = Date(timeIntervalSince1970: TimeInterval(minutelyWeatherModel.time))
        return date.description
    }
    
    func getPrecipIntensity() -> String {
        return minutelyWeatherModel.precipIntensity.description
    }
    
}
