//
//  ImageEntity+CoreDataProperties.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var imageData: Data?

}

extension ImageEntity : Identifiable {

}
