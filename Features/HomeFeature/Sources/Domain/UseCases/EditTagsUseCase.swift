//
//  EditTagsUseCase.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/17/24.
//

import Foundation

public protocol EditTagsUseCase {
    func execute(cafe: Cafe) async throws
}

public final class EditTagsUseCaseImpl: EditTagsUseCase {
    private let repository: CafeRepository
    
    public init(repository: CafeRepository) {
        self.repository = repository
    }
    
    public func execute(cafe: Cafe) async throws {
        try await repository.updateCafe(cafe)
    }
}
