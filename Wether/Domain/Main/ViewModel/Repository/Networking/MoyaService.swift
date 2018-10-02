//
//  MoyaService.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import Moya

enum MoyaService {
    case weather
}

extension MoyaService: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.mocky.io/v2")!
    }
    
    var path: String {
        return "5bb1c1092e0000b3159271f1"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "chjoki sik inchi hamar e".utf8Encoded
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
