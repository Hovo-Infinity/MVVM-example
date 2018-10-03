//
//  DataRepository.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class DataRepository {
    let disposeBug = DisposeBag()
    
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    
    private static let sInstance = DataRepository()
    
    private init() {
        
    }
    
//    private let provider = MoyaProvider<MoyaService>(plugins:[MoyaPlugin { result in
//        return result
//        }])
    private let provider = MoyaProvider<MoyaService>()
    private var allData: BehaviorRelay<WetherData?> = BehaviorRelay(value: nil)
    
    
    
    static func getInstance() -> DataRepository {
        return sInstance
    }
    
    
    func getDatas() {
        return provider.rx.request(.weather)
            .asObservable()
            .subscribe({[weak self] event in
                switch event {
                case .error(let error):
                    print(error)
                    break
                case .completed:
                    print("completed")
                    self?.isLoading.accept(false)
                    break
                case .next(let element):
                    do {
                        let response = try JSONDecoder().decode(WetherData.self, from: element.data)
                        self?.allData.accept(response)
                    } catch {
                        print(error)
                    }
                    break
                }
            })
        .disposed(by: disposeBug)
    }
    
    func getObservableWeather() -> Observable<[MinutelyWeather]?> {
        return MinutelyDataRepository.getInstance().getObservableWeather()
    }
}
