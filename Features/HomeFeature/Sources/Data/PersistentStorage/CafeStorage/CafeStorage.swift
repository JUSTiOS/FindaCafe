//
//  CafeStorage.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 5/29/24.
//

public protocol CafeStorage {
    func fetchCafes() async throws -> [Cafe]
    func addCafe(_ cafe: Cafe) async throws
    func updateCafe(_ cafe: Cafe) async throws
    func deleteCafe(_ cafe: Cafe) async throws
}
