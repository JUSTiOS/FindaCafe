import CoreData

public final class PersistenceController {
    static let shared = PersistenceController()
    
    private let persistentContainer: NSPersistentContainer
    
    public init(inMemory: Bool = false) {
        guard let modelURL = Bundle.module.url(forResource: "CafeData", withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Cannot find Cafe.momd")
        }
        
        let container = NSPersistentContainer(
            name: "CafeData",
            managedObjectModel: managedObjectModel
        )
        
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // TODO: - Log to Crashlytics
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistentContainer = container
    }
    
    public func performBackgroundTask<T>(_ block: @escaping (NSManagedObjectContext) throws -> T) async rethrows -> T {
        try await persistentContainer.performBackgroundTask(block)
    }
}
