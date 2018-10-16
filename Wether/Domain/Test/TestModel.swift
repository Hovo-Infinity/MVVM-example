//
//  TestModel.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/5/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import CoreData

extension Video {
    var humanReadableDuration: String {
        let prefix = duration[String.Index(encodedOffset: 2)...]
        var readableDuration = prefix.replacingOccurrences(of: "M", with: " : ")
        readableDuration = readableDuration.replacingOccurrences(of: "H", with: " : ")
        readableDuration.removeLast(1)
        return readableDuration
    }
}

