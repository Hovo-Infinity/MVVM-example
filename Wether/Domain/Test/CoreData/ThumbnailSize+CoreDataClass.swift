//
//  ThumbnailSize+CoreDataClass.swift
//  
//
//  Created by Hovhannes Stepanyan on 10/15/18.
//
//

import Foundation
import CoreData

@objc(ThumbnailSize)
public class ThumbnailSize: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case width, height
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataManager.sInstance.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "ThumbnailSize", in: context) else {
            fatalError("me errorm exav eli esim")
        }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let w = try container.decode(Int.self, forKey: .width)
        width = NSNumber(integerLiteral: w)
        let h = try container.decode(Int.self, forKey: .height)
        height = NSNumber(integerLiteral: h)
    }
}
