//
//  CoreDataCafeStorage.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//

import CoreData

enum CoreDataCafeStorageError: Error {
    case dataCorrupted
}

public final class CoreDataCafeStorage: CafeStorage {
    private let coreDataStorage: CoreDataStorage
    
    public init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
    
    public func fetchCafes() async throws -> [Cafe] {
        return try await coreDataStorage.performBackgroundTask { context in
            let request: NSFetchRequest<CafeEntity> = CafeEntity.fetchRequest()
            
            return try context.fetch(request).map { $0.toDomain() }
        }
    }
    
    public func addCafe(_ cafe: Cafe) async throws {
        try await coreDataStorage.performBackgroundTask { context in
            guard try self.fetchEntity(cafe: cafe, inContext: context) == nil else {
                return
            }
            
            let cafeEntity = CafeEntity(cafe: cafe, insertInto: context)
            
            for tag in cafe.tags {
                if let tagEntity = try self.fetchEntity(tag: tag, inContext: context) {
                    tagEntity.addToCafes(cafeEntity)
                } else {
                    TagEntity(tag: tag, insertInto: context).addToCafes(cafeEntity)
                }
            }
            
            try context.save()
        }
    }
    
    public func updateCafe(_ cafe: Cafe) async throws {
        try await deleteCafe(cafe)
        try await addCafe(cafe)
    }
    
    public func deleteCafe(_ cafe: Cafe) async throws {
        try await coreDataStorage.performBackgroundTask { context in
            guard let cafeEntity = try self.fetchEntity(cafe: cafe, inContext: context) else {
                return
            }
            
            context.delete(cafeEntity)
            
            try context.save()
        }
    }
    
    private func fetchEntity(cafe: Cafe, inContext: NSManagedObjectContext) throws -> CafeEntity? {
        let request: NSFetchRequest<CafeEntity> = CafeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", cafe.id)
        
        let cafeEntities = try inContext.fetch(request)
        
        guard cafeEntities.count < 2 else {
            throw CoreDataCafeStorageError.dataCorrupted
        }
        
        return cafeEntities.first
    }
    
    private func fetchEntity(tag: Tag, inContext: NSManagedObjectContext) throws -> TagEntity? {
        let request: NSFetchRequest<TagEntity> = TagEntity.fetchRequest()
        
        switch tag.category {
        case .some(let tagCategory):
            request.predicate = NSPredicate(format: "%K == %@ AND %K == %@",
                                            #keyPath(TagEntity.category), tagCategory.rawValue,
                                            #keyPath(TagEntity.name), tag.name)
        case .none:
            request.predicate = NSPredicate(format: "%K == NIL AND %K == %@",
                                            #keyPath(TagEntity.category),
                                            #keyPath(TagEntity.name), tag.name)
        }
        
        let tagEntities = try inContext.fetch(request)
        
        guard tagEntities.count < 2 else {
            throw CoreDataCafeStorageError.dataCorrupted
        }
        
        return tagEntities.first
    }
}
