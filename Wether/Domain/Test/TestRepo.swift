//
//  TestRepo.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/5/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import Moya
import RxSwift

//  http://www.mocky.io/v2
enum TestTargetType {
    case basic(_ version: Int)
}
extension TestTargetType: TargetType {
    internal var baseURL: URL {
        return try! "http://www.mocky.io".asURL()
    }
    
    var path: String {
        switch self {
        case .basic(let page):
            switch page {
            case 1:
                return "/v2/5bbdeed131000083007112a1"
            case 2:
                return "/v2/5bbdf5ed3100007c007112e6"
            default:
                return ""
            }
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "chjoki sik inchi hamar e".utf8Encoded
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

class TestRepo {
    let apiProvider = MoyaProvider<TestTargetType>()
    
    func fetchData(forPage page: Int) -> Observable<[Video]> {
        return apiProvider.rx
            .request(TestTargetType.basic(page))
            .asObservable()
            .map {
                let data = $0.data
                return try JSONDecoder().decode([Video].self, from: data)
            }
            .asDriver(onErrorJustReturn: [])
            .asObservable()
    }
    
}
