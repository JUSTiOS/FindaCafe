import CoreData

public protocol CoreDataProtocol {
    func fetchCafes() async throws -> [Cafe]
    func addCafe(_ cafe: Cafe) async throws
    func updateCafe(_ cafe: Cafe) async throws
    func deleteCafe(_ cafe: Cafe) async throws
}

enum CoreDataError: Error {
    case fetchError
    case addError
    case updateError
    case deleteError
}

public final class CafeCoreDataManager: CoreDataProtocol {
    private let coreDataManager: PersistenceController
    
    public init(coreDataManager: PersistenceController) {
        self.coreDataManager = coreDataManager
    }
    
    public func fetchCafes() async throws -> [Cafe] {
        return try await coreDataManager.performBackgroundTask { context in
            let request: NSFetchRequest<CafeEntity> = CafeEntity.fetchRequest()
            
            return try context.fetch(request).map { $0.toDomain() }
        }
    }
    
    public func addCafe(_ cafe: Cafe) async throws {
        try await coreDataManager.performBackgroundTask { context in
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
        try await coreDataManager.performBackgroundTask { context in
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
            throw CoreDataError.fetchError
        }
        
        return cafeEntities.first
    }
    
    private func fetchEntity(tag: Tag, inContext: NSManagedObjectContext) throws -> TagEntity? {
        let request: NSFetchRequest<TagEntity> = TagEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@ AND %K == %i",
                                        #keyPath(TagEntity.name), tag.name,
                                        #keyPath(TagEntity.category), tag.category.rawValue)
        
        let tagEntities = try inContext.fetch(request)
        
        guard tagEntities.count < 2 else {
            throw CoreDataError.fetchError
        }
        
        return tagEntities.first
    }
}
