//
//  TagEntity+CoreDataProperties.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//
//

import Foundation
import CoreData


extension TagEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagEntity> {
        return NSFetchRequest<TagEntity>(entityName: "TagEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var name: String
    @NSManaged public var cafes: NSSet

}

// MARK: Generated accessors for cafes
extension TagEntity {

    @objc(addCafesObject:)
    @NSManaged public func addToCafes(_ value: CafeEntity)

    @objc(removeCafesObject:)
    @NSManaged public func removeFromCafes(_ value: CafeEntity)

    @objc(addCafes:)
    @NSManaged public func addToCafes(_ values: NSSet)

    @objc(removeCafes:)
    @NSManaged public func removeFromCafes(_ values: NSSet)

}

extension TagEntity : Identifiable {

}
