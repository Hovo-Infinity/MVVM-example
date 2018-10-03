//
//  BaseVC.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/3/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {
    
    let disposebag = DisposeBag()
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        view.hidesWhenStopped = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        DataRepository.getInstance().isLoading
            .bind { animated in
                self.activityIndicatorView.isLoading = animated
            }
            .disposed(by: disposebag)
    }
}
