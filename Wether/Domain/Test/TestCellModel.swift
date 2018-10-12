//
//  TestCellModel.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/10/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import RxDataSources

struct TestCellModel {
    var name: String
    var duration: String
    var imageURL: URL?
}

struct TestSectionModel {
    var header: String
    var items: [Item]
}

extension TestSectionModel: SectionModelType {
    typealias Item = Video
    
    init(original: TestSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
