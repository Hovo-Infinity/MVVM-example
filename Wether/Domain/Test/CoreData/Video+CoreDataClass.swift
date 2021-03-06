//
//  Video+CoreDataClass.swift
//  
//
//  Created by Hovhannes Stepanyan on 10/15/18.
//
//

import Foundation
import CoreData

@objc(Video)
public class Video: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case desc = "description"
        case datePublished, publisher, creator
        case contentURL = "contentUrl"
        case hostPageURL = "hostPageUrl"
        case encodingFormat
        case hostPageDisplayURL = "hostPageDisplayUrl"
        case width, height, duration, viewCount
        case thumbnailSize = "thumbnail"
        case videoID = "videoId"
        case isAllowMobileEmbed = "allowMobileEmbed"
        case isSuperfresh, name
        case thumbnailURL = "thumbnailUrl"
        case webSearchURL = "webSearchUrl"
        case motionThumbnailURL = "motionThumbnailUrl"
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        let context = CoreDataManager.sInstance.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Video", in: context) else {
            fatalError("me errorm exav eli esim")
        }
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let videoId = try container.decode(String.self, forKey: .videoID)
        if let _ = CoreDataManager.objectForEntityType(Video.self, primaryKey: "videoID", value: videoId) {
            self.init(entity: entity, insertInto: nil)
        } else {
            self.init(entity: entity, insertInto: context)
            let publishers = try container.decode([Creator].self, forKey: CodingKeys.publisher)
            publisher = NSOrderedSet(array: publishers)
            thumbnailSize = try container.decode(ThumbnailSize.self, forKey: .thumbnailSize)
            creator = try container.decode(Creator.self, forKey: .creator)
        }
        desc = try container.decode(String.self, forKey: .desc)
        datePublished = try container.decode(String.self, forKey: .datePublished)
        contentURL = try container.decode(String.self, forKey: .contentURL)
        hostPageURL = try container.decode(String.self, forKey: .hostPageURL)
        encodingFormat = try container.decode(String.self, forKey: .encodingFormat)
        hostPageDisplayURL = try container.decode(String.self, forKey: .hostPageDisplayURL)
        duration = try container.decode(String.self, forKey: .duration)
        videoID = videoId
        isSuperfresh = try container.decode(Bool.self, forKey: .isSuperfresh)
        isAllowMobileEmbed = try container.decode(Bool.self, forKey: .isAllowMobileEmbed)
        name = try container.decode(String.self, forKey: .name)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
        webSearchURL = try container.decode(String.self, forKey: .webSearchURL)
        viewCount = try container.decode(Int32.self, forKey: .viewCount)
        width = try container.decode(Int32.self, forKey: .width)
        height = try container.decode(Int32.self, forKey: .height)
    }
}
