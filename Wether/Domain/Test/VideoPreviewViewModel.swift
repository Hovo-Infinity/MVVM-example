//
//  VideoPreviewViewModel.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/12/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct VideoPreviewViewModel: BaseViewModeling {
    var model: BehaviorRelay<Video>!
    var error = PublishSubject<Error>()
    var disposeBag: DisposeBag
    
    init(disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
    }
    
    init(disposeBag: DisposeBag, model: Video) {
        self.init(disposeBag: disposeBag)
        self.model = BehaviorRelay(value: model)
    }
}
