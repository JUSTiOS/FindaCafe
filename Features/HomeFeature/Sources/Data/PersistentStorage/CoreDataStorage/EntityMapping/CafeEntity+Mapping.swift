//
//  CafeEntity+Mapping.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/3/24.
//

import CoreData

extension CafeEntity {
    convenience init(cafe: Cafe, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = cafe.id
        self.addedDate = Date()
        self.address = cafe.address
        self.latitude = cafe.coord.latitude
        self.longitude = cafe.coord.longitude
        self.name = cafe.name
        self.phone = cafe.phone
        self.placeURL = URL(string: cafe.placeURL)!
    }
}

extension CafeEntity {
    func toDomain() -> Cafe {
        return .init(
            id: id,
            name: name,
            address: address,
            phone: phone,
            coord: Coord(longitude: longitude, latitude: latitude),
            placeURL: placeURL.absoluteString,
            tags: Set(tags.map { ($0 as! TagEntity).toDomain() })
        )
    }
}
