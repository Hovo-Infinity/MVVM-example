//
//  SimpleTimelyWetherProtocol.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/2/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

protocol SimpleTimelyWetherProtocol {
    associatedtype T
    
    var summary: String { get }
    var icon: String { get }
    var data: [T] { get }
}
