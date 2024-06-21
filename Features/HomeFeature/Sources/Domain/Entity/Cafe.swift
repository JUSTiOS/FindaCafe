//
//  Cafe.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 5/29/24.
//

import Foundation

public struct Coord: Hashable {
    let longitude: Double
    let latitude: Double
}

public struct Cafe: Identifiable, Hashable {
    public let id: String
    var name: String
    var address: String
    var phone: String
    var coord: Coord
    var placeURL: String
    var tags: Set<Tag>
}
