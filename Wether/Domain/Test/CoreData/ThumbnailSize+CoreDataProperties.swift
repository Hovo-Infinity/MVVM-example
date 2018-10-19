//
//  ThumbnailSize+CoreDataProperties.swift
//  
//
//  Created by Hovhannes Stepanyan on 10/15/18.
//
//

import Foundation
import CoreData


extension ThumbnailSize {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThumbnailSize> {
        return NSFetchRequest<ThumbnailSize>(entityName: "ThumbnailSize")
    }

    @NSManaged public var width: Int32
    @NSManaged public var height: Int32

}
