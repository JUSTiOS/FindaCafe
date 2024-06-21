//
//  CafeEntity+CoreDataProperties.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
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
    @NSManaged public var id: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var placeURL: URL
    @NSManaged public var tags: NSSet

}

// MARK: Generated accessors for tags
extension CafeEntity {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: TagEntity)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: TagEntity)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension CafeEntity : Identifiable {

}
