import Foundation

struct NearbyCafeDTO: Decodable {
    var meta: Meta
    var documents: [Document]
}

struct Meta: Decodable {
    var totalCount: Int
    var pageableCount: Int
    var isEnd: Bool
    var sameName: SameName
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
        case sameName = "same_name"
    }
}

struct SameName: Decodable {
    var region: [String]
    var keyword: String
    var selectedRegion: String
    
    private enum CodingKeys: String, CodingKey {
        case region, keyword
        case selectedRegion = "selected_region"
    }
}

struct Document: Decodable {
    var id: String
    var placeName: String
    var categoryName: String
    var categoryGroupCode: String
    var categoryGroupName: String
    var phone: String
    var addressName: String
    var roadAddressName: String
    var x: String
    var y: String
    var placeUrl: String
    var distance: String
    
    private enum CodingKeys: String, CodingKey {
        case id, phone, x, y, distance
        case placeName = "place_name"
        case categoryName = "category_name"
        case categoryGroupCode = "catetory_group_code"
        case categoryGroupName = "catetory_group_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case placeUrl = "place_url"
    }
}
