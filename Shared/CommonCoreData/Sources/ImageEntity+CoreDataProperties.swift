//
//  ImageEntity+CoreDataProperties.swift
//  
//
//  Created by Yejin Hong on 8/27/24.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var imageData: Data

}
