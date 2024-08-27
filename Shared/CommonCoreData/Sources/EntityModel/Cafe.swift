import Foundation

public struct Coord: Hashable {
    let longitude: Double
    let latitude: Double
}

public struct Cafe: Identifiable, Hashable {
    public let id: String
    var cafeName: String
    var address: String
    var phone: String
    var coord: Coord
    var placeURL: String
    var tags: Set<Tag>
    var categoryName: String
    var distance: Double
    var liked: Bool
}
