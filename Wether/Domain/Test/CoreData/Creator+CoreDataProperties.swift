//
//  Creator+CoreDataProperties.swift
//  
//
//  Created by Hovhannes Stepanyan on 10/15/18.
//
//

import Foundation
import CoreData


extension Creator {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Creator> {
        return NSFetchRequest<Creator>(entityName: "Creator")
    }

    @NSManaged public var name: String

}
