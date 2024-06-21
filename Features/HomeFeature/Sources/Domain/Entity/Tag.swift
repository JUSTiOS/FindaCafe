//
//  Tag.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/3/24.
//

import Foundation

public struct Tag: Hashable {
    enum Category: String {
        case mood
        case cafeSize
        case congestion
        case powerOutlet
        case toilet
    }
    
    let name: String
    let category: Category?
    
    init(name: String, category: Category?) {
        self.name = name
        self.category = category
    }
}
