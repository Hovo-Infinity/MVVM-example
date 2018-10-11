//
//  TestViewModel.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/5/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct TestViewModel {
    private var disposeBag: DisposeBag
    private var repo = TestRepo()
    private var hasNextPage = BehaviorRelay(value: false)
    private var isLoadingVar = BehaviorRelay(value: true)
    private var errorSubject = PublishSubject<Error>()
    private(set) var model: BehaviorRelay<[Video]>
    
    
    var isLoading: Observable<Bool> {
        return isLoadingVar.asObservable()
    }
    
    var error: Observable<Error> {
        return errorSubject.asObservable()
    }
    
    init(disposeBag: DisposeBag) {
        self.disposeBag = disposeBag
        model = BehaviorRelay(value: [])
        fetchData()
    }
}

extension TestViewModel {
    func bindObservableToRefresh(_ observable: Observable<Void>) {
        observable.do(onNext: {
            self.isLoadingVar.accept(true)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        })
            .do(onNext: { _ in
                self.isLoadingVar.accept(false)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .bind(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func fetchData() {
        repo.fetchData(forPage: 1)
            .subscribe(onNext: { videos in
                self.hasNextPage.accept(true)
                self.model.accept(videos)
            }, onError: { error in
                self.errorSubject.onNext(error)
            }, onCompleted: {
                self.isLoadingVar.accept(false)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .disposed(by: disposeBag)
    }
    
    public func fetchDatas(page: Int) {
        if  hasNextPage.value {
            repo.fetchData(forPage: page)
                .do(onNext: {_ in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
                .bind(onNext: { videos in
                    self.hasNextPage.accept(page < 2)
                    self.model.accept(self.model.value + videos)
                })
                .disposed(by: disposeBag)
        }
    }
}
