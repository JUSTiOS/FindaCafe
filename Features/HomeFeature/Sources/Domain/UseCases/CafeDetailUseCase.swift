//
//  CafeDetailUseCase.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//

protocol CafeDetailUseCase {
    func editTags(of cafe: Cafe) async throws
    func deleteCafe(_ cafe: Cafe) async throws
}
