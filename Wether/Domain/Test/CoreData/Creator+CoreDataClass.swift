//
//  Creator+CoreDataClass.swift
//  
//
//  Created by Hovhannes Stepanyan on 10/15/18.
//
//

import Foundation
import CoreData

@objc(Creator)
public class Creator: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataManager.sInstance.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Creator", in: context) else {
            fatalError("me errorm exav eli esim")
        }
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
}
