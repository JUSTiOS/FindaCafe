//
//  CafeRepositoryImpl.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//

public final class CafeRepositoryImpl {
    private let persistentStorage: CafeStorage
    
    public init(persistentStorage: CafeStorage) {
        self.persistentStorage = persistentStorage
    }
}

extension CafeRepositoryImpl: CafeRepository {
    public func fetchCafes() async throws -> [Cafe] {
        try await persistentStorage.fetchCafes()
    }
    
    public func addCafe(_ cafe: Cafe) async throws {
        try await persistentStorage.addCafe(cafe)
    }
    
    public func updateCafe(_ cafe: Cafe) async throws {
        try await persistentStorage.updateCafe(cafe)
    }
    
    public func deleteCafe(_ cafe: Cafe) async throws {
        try await persistentStorage.deleteCafe(cafe)
    }
}
