//
//  LoadCafeListUseCase.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/17/24.
//

import Foundation

public protocol LoadCafeListUseCase {
    func execute() async throws -> [Cafe]
}

public final class LoadCafeListUseCaseImpl: LoadCafeListUseCase {
    private let repository: CafeRepository
    
    public init(repository: CafeRepository) {
        self.repository = repository
    }
    
    public func execute() async throws -> [Cafe] {
        return try await repository.fetchCafes()
    }
}

public final class LoadCafeListUseCaseMock: LoadCafeListUseCase {
    public init() {
        
    }
    
    public func execute() async throws -> [Cafe] {
        return [
            Cafe(id: "1234", name: "스타벅스", address: "경기도 안양시 동안구 시민대로 222", phone: "031-123-1234", coord: Coord(longitude: 126.9533556, latitude: 37.3897), placeURL: "https://naver.com", tags: [Tag(name: "조용함", category: .mood), Tag(name: "혼잡", category: .congestion)]),
            Cafe(id: "2345", name: "이디야", address: "경기도 안양시 동안구 시민대로 223", phone: "031-123-1234", coord: Coord(longitude: 126.8468194, latitude: 37.29851944), placeURL: "https://google.com", tags: [Tag(name: "시끄러움", category: .mood), Tag(name: "넓음", category: .cafeSize), Tag(name: "상쾌함", category: nil)])
        ]
    }
}
