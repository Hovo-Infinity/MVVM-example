//
//  TestModel.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/5/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

struct Video: Decodable {
    let description, datePublished: String
    let publisher: [Creator]
    let creator: Creator
    let contentURL, hostPageURL: String
    let encodingFormat: String
    let hostPageDisplayURL: String
    let width, height: Int
    let duration: String
    let viewCount: Int
    let thumbnailSize: ThumbnailSize
    let videoID: String
    let allowMobileEmbed, isSuperfresh: Bool
    let name: String
    let thumbnailURL, webSearchURL: String
    
    enum CodingKeys: String, CodingKey {
        case description, datePublished, publisher, creator
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
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
        datePublished = try container.decode(String.self, forKey: .datePublished)
        publisher = try container.decode([Creator].self, forKey: .publisher)
        creator = try container.decode(Creator.self, forKey: .creator)
        contentURL = try container.decode(String.self, forKey: .contentURL)
        hostPageURL = try container.decode(String.self, forKey: .hostPageURL)
        encodingFormat = try container.decode(String.self, forKey: .encodingFormat)
        hostPageDisplayURL = try container.decode(String.self, forKey: .hostPageDisplayURL)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
        duration = try container.decode(String.self, forKey: .duration)
        viewCount = try container.decode(Int.self, forKey: .viewCount)
        thumbnailSize = try container.decode(ThumbnailSize.self, forKey: .thumbnailSize)
        videoID = try container.decode(String.self, forKey: .videoID)
        allowMobileEmbed = try container.decode(Bool.self, forKey: .allowMobileEmbed)
        isSuperfresh = try container.decode(Bool.self, forKey: .isSuperfresh)
        name = try container.decode(String.self, forKey: .name)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
        webSearchURL = try container.decode(String.self, forKey: .webSearchURL)
    }
}

extension Video {
    var humanReadableDuration: String {
        let prefix = duration[String.Index(encodedOffset: 2)...]
        var readableDuration = prefix.replacingOccurrences(of: "M", with: " : ")
        readableDuration = readableDuration.replacingOccurrences(of: "H", with: " : ")
        readableDuration.removeLast(1)
        return readableDuration
    }
}

struct Creator: Decodable {
    let name: String
}

struct ThumbnailSize: Decodable {
    let width, height: Int
}

