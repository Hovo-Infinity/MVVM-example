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

class DataRepository {
    
    private static let sInstance = DataRepository()
    
    private init() {
        
    }
    
//    private let provider = MoyaProvider<MoyaService>(plugins:[MoyaPlugin { result in
//        return result
//        }])
    private let provider = MoyaProvider<MoyaService>()
    private var allData: WetherData?
    
    
    
    static func getInstance() -> DataRepository {
        return sInstance
    }
    
    
    func getDatas() -> Observable<Response> {
        return provider.rx.request(.weather)
            .asObservable()
            .share()
    }
}
