//
//  DeleteCafeUseCase.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/17/24.
//

import Foundation

public protocol DeleteCafeUseCase {
    func execute(cafe: Cafe) async throws
}


public final class DeleteCafeUseCaseImpl: DeleteCafeUseCase {
    private let repository: CafeRepository
    
    public init(repository: CafeRepository) {
        self.repository = repository
    }
    
    public func execute(cafe: Cafe) async throws {
        try await repository.deleteCafe(cafe)
    }
}
