//
//  UIActivityIndicatorView+Loading.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/3/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    var isLoading: Bool {
        set {
            if newValue {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
        get {
            return isAnimating
        }
    }
}
