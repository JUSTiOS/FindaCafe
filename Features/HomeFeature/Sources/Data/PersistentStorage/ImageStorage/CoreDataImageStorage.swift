//
//  CoreDataImageStorage.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//

import CoreData

final class CoreDataImageStorage: ImageStorage {
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
    
    func updateImage(of cafe: Cafe, to data: Data) async throws {
        // TODO: - Should be implemented
        print("TODO: - Should be implemented")
    }
    
    func removeImage(of cafe: Cafe) async throws {
        // TODO: - Should be implemented
        print("TODO: - Should be implemented")
    }
}
