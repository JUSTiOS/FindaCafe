//
//  CafeRepository.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//

public protocol CafeRepository {
    func fetchCafes() async throws -> [Cafe]
    func addCafe(_ cafe: Cafe) async throws
    func updateCafe(_ cafe: Cafe) async throws
    func deleteCafe(_ cafe: Cafe) async throws
}
