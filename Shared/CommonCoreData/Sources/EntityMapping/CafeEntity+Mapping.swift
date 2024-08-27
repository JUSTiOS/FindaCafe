import CoreData

extension CafeEntity {
    convenience init(cafe: Cafe, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = cafe.id
        self.addedDate = Date()
        self.address = cafe.address
        self.latitude = cafe.coord.latitude
        self.longitude = cafe.coord.longitude
        self.cafeName = cafe.cafeName
        self.phone = cafe.phone
        self.placeURL = URL(string: cafe.placeURL)!
        self.categoryName = cafe.categoryName
        self.distance = cafe.distance
        self.liked = cafe.liked
    }
}

extension CafeEntity {
    func toDomain() -> Cafe {
        return .init(
            id: id,
            cafeName: cafeName,
            address: address,
            phone: phone,
            coord: Coord(longitude: longitude, latitude: latitude),
            placeURL: placeURL.absoluteString,
            tags: Set(_immutableCocoaSet: tags),
            categoryName: categoryName,
            distance: distance,
            liked: liked
        )
    }
}
