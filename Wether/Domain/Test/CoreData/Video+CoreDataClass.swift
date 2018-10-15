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
        case allowMobileEmbed, isSuperfresh, name
        case thumbnailURL = "thumbnailUrl"
        case webSearchURL = "webSearchUrl"
        case motionThumbnailURL = "motionThumbnailUrl"
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        let context = CoreDataManager.sInstance.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Video", in: context) else {
            fatalError("me errorm exav eli esim")
        }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        desc = try container.decode(String.self, forKey: .desc)
        datePublished = try container.decode(String.self, forKey: .datePublished)
        let publishers = try container.decode([Creator].self, forKey: CodingKeys.publisher)
        publisher = NSOrderedSet(array: publishers)
        creator = try container.decode(Creator.self, forKey: .creator)
        contentURL = try container.decode(String.self, forKey: .contentURL)
        hostPageURL = try container.decode(String.self, forKey: .hostPageURL)
        encodingFormat = try container.decode(String.self, forKey: .encodingFormat)
        hostPageDisplayURL = try container.decode(String.self, forKey: .hostPageDisplayURL)
        duration = try container.decode(String.self, forKey: .duration)
        videoID = try container.decode(String.self, forKey: .videoID)
        allowMobileEmbed = NSNumber(booleanLiteral: try container.decode(Bool.self, forKey: .allowMobileEmbed))
        isSuperfresh = try container.decode(Bool.self, forKey: .isSuperfresh)
        name = try container.decode(String.self, forKey: .name)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
        webSearchURL = try container.decode(String.self, forKey: .webSearchURL)
        let vc = try container.decode(Int.self, forKey: .viewCount)
        viewCount = NSNumber(integerLiteral: vc)
        let w = try container.decode(Int.self, forKey: .width)
        width = NSNumber(integerLiteral: w)
        let h = try container.decode(Int.self, forKey: .height)
        height = NSNumber(integerLiteral: h)
        thumbnailSize = try container.decode(ThumbnailSize.self, forKey: .thumbnailSize)
    }
}
