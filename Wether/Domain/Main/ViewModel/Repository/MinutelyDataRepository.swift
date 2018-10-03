//
//  MinutelyDataRepository.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/3/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MinutelyDataRepository {
    private var data: BehaviorRelay<MinutelyWetherData?> = BehaviorRelay(value: nil)
    
    private static let sInstance = MinutelyDataRepository()
    
    private init() {
        
    }
    
    static func getInstance() -> MinutelyDataRepository {
        return sInstance
    }
    
    func updateData(_ data: MinutelyWetherData) {
        self.data.accept(data)
    }
    
    func getObservableWeather() -> Observable<[MinutelyWeather]?> {
        return Observable.from(optional: self.data.value?.data)
    }
}
