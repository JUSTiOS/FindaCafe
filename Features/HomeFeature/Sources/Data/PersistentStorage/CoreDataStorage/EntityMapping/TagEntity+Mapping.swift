//
//  TagEntity+Mapping.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/3/24.
//

import CoreData

extension TagEntity {
    convenience init(tag: Tag, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = tag.name
        self.category = tag.category?.rawValue
    }
}

extension TagEntity {
    func toDomain() -> Tag {
        return .init(
            name: name,
            category: Tag.Category(rawValue: category ?? "")
        )
    }
}
