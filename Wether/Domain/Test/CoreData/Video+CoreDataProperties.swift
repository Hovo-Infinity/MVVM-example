//
//  Video+CoreDataProperties.swift
//  
//
//  Created by Hovhannes Stepanyan on 10/15/18.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var desc: String
    @NSManaged public var datePublished: String
    @NSManaged public var contentURL: String
    @NSManaged public var hostPageURL: String
    @NSManaged public var encodingFormat: String
    @NSManaged public var hostPageDisplayURL: String
    @NSManaged public var width: Int32
    @NSManaged public var height: Int32
    @NSManaged public var duration: String
    @NSManaged public var viewCount: Int32
    @NSManaged public var videoID: String
    @NSManaged internal var isAllowMobileEmbed: Bool
    @NSManaged public var isSuperfresh: Bool
    @NSManaged public var name: String
    @NSManaged public var thumbnailURL: String
    @NSManaged public var webSearchURL: String
    @NSManaged public var publisher: NSOrderedSet
    @NSManaged public var creator: Creator
    @NSManaged public var thumbnailSize: ThumbnailSize

}

// MARK: Generated accessors for publisher
extension Video {

    @objc(insertObject:inPublisherAtIndex:)
    @NSManaged public func insertIntoPublisher(_ value: Creator, at idx: Int)

    @objc(removeObjectFromPublisherAtIndex:)
    @NSManaged public func removeFromPublisher(at idx: Int)

    @objc(insertPublisher:atIndexes:)
    @NSManaged public func insertIntoPublisher(_ values: [Creator], at indexes: NSIndexSet)

    @objc(removePublisherAtIndexes:)
    @NSManaged public func removeFromPublisher(at indexes: NSIndexSet)

    @objc(replaceObjectInPublisherAtIndex:withObject:)
    @NSManaged public func replacePublisher(at idx: Int, with value: Creator)

    @objc(replacePublisherAtIndexes:withPublisher:)
    @NSManaged public func replacePublisher(at indexes: NSIndexSet, with values: [Creator])

    @objc(addPublisherObject:)
    @NSManaged public func addToPublisher(_ value: Creator)

    @objc(removePublisherObject:)
    @NSManaged public func removeFromPublisher(_ value: Creator)

    @objc(addPublisher:)
    @NSManaged public func addToPublisher(_ values: NSOrderedSet)

    @objc(removePublisher:)
    @NSManaged public func removeFromPublisher(_ values: NSOrderedSet)

}
