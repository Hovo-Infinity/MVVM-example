//
//  MoyaPlugin.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import Moya
import Result

class MoyaPlugin: PluginType {
    
    private var parser: Optional<(Result<Moya.Response, MoyaError>) -> Result<Moya.Response, MoyaError>>
    
    init(_ parserBlock: Optional<(Result<Moya.Response, MoyaError>) -> Result<Moya.Response, MoyaError>> = nil) {
        parser = parserBlock
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("MoyaPlugin.\(#function)")
    }
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case .failure(let error):
            // handle general errors
            break
        default:
            break
        }
    }
    
    func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        if parser.notNil() {
            return parser.unsafelyUnwrapped(result)
        }
        return result
    }
}
