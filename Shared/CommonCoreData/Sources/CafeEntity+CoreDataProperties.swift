//
//  CafeEntity+CoreDataProperties.swift
//  
//
//  Created by Yejin Hong on 8/27/24.
//
//

import Foundation
import CoreData


extension CafeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CafeEntity> {
        return NSFetchRequest<CafeEntity>(entityName: "CafeEntity")
    }

    @NSManaged public var addedDate: Date
    @NSManaged public var address: String
    @NSManaged public var cafeName: String
    @NSManaged public var categoryName: String
    @NSManaged public var distance: Double
    @NSManaged public var id: String
    @NSManaged public var latitude: Double
    @NSManaged public var liked: Bool
    @NSManaged public var longitude: Double
    @NSManaged public var phone: String
    @NSManaged public var placeURL: URL
    @NSManaged public var tags: TagEntity

}
