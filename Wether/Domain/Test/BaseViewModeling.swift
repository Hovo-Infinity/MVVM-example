//
//  BaseViewModeling.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/12/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModeling {
    associatedtype Item
    
    var model: BehaviorRelay<Item>! { get }
    var error: PublishSubject<Error> { get }
    var disposeBag: DisposeBag { get }
    
    init(disposeBag: DisposeBag)
}
