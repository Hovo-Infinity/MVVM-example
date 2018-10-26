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

struct TestViewModel: BaseViewModeling {
    internal var disposeBag: DisposeBag
    private var repo = TestRepo()
    private var hasNextPage = BehaviorRelay(value: false)
    private var loading = BehaviorRelay(value: true)
    var error = PublishSubject<Error>()
    var model: BehaviorRelay<[Video]>!
    private var currentPage = BehaviorRelay(value: 1)
    
    var isLoading: Observable<Bool> {
        return loading.asObservable()
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
            self.loading.accept(true)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        })
            .do(onNext: { _ in
                self.loading.accept(false)
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
                self.hasNextPage.accept(!videos.isEmpty)
                self.model.accept(videos)
                self.currentPage.accept(self.currentPage.value + 1)
            }, onError: { error in
                self.error.onNext(error)
            }, onCompleted: {
                self.loading.accept(false)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .disposed(by: disposeBag)
    }
    
    public func fetchNext() {
        if  hasNextPage.value {
            repo.fetchData(forPage: currentPage.value)
                .do(onNext: {_ in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
                .bind(onNext: { videos in
                    self.hasNextPage.accept(!videos.isEmpty)
                    self.model.accept(self.model.value + videos)
                    self.currentPage.accept(self.currentPage.value + 1)
                })
                .disposed(by: disposeBag)
        }
    }
    
    public func previewViewModelFor(_ video: Video) -> VideoPreviewViewModel {
        return VideoPreviewViewModel(disposeBag: disposeBag, model: video)
    }
}
