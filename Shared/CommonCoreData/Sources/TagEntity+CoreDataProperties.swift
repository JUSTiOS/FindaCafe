//
//  TagEntity+CoreDataProperties.swift
//  
//
//  Created by Yejin Hong on 8/27/24.
//
//

import Foundation
import CoreData


extension TagEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagEntity> {
        return NSFetchRequest<TagEntity>(entityName: "TagEntity")
    }

    @NSManaged public var category: Int16
    @NSManaged public var name: String
    @NSManaged public var cafes: CafeEntity

}

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
