//
//  TestLoginViewModel.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import RxSwift
import RxCocoa

struct TestLoginViewModel {
    let validEmail: Observable<Bool>
    let validPassword: Observable<Bool>
    let validFields: Observable<Bool>
    
    init(email: ControlProperty<String?>, password: ControlProperty<String?>, disposeBag: DisposeBag) {
        validEmail = email.orEmpty
            .map {
                let regExp = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
                    "\\@" +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                    "(" +
                    "\\." +
                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                ")+"
                let predicate = NSPredicate(format: "SELF MATCHES %@", regExp)
                return predicate.evaluate(with: $0)
            }
            .share(replay: 1)
        
        validPassword = password.orEmpty
            .map {
                $0.count > 8
            }
            .share(replay: 1)
        
        validFields = Observable.combineLatest(validEmail, validPassword, resultSelector: {
            $0 && $1
        })
    }
}
