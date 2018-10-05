//
//  MinutelyCellListViewModel.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/3/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MinutelyCellListViewModel {
    var disposeBag = DisposeBag()
    
    var minutelyCellModels: BehaviorRelay<[MinutelyCellViewModel]> = BehaviorRelay(value: [])
    
    private var models: [MinutelyWeather] = [] {
        didSet {
            var value = self.minutelyCellModels.value
            value = models.map({ MinutelyCellViewModel(model: $0) })
            self.minutelyCellModels.accept(value)
        }
    }
    
    private var summary = Variable<String>("")
    
    func fetchData() {
        DataRepository.getInstance().getObservableWeather()
            .subscribe { event in
                switch event {
                case .next(let elem):
                    if elem.notNil() {
                        self.models = elem!.data
                    }
                    break
                case .completed:
                    if let element = event.element {
                        self.models = element!.data
                    }
                    break
                case .error(_):
                    break
                }
            }
        .disposed(by: disposeBag)
    }
    
    func getSummary() -> Observable<String> {
        return DataRepository.getInstance().getMinutelyWeatherSummary()
    }
    
}
