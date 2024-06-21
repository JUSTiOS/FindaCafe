//
//  CoreDataStorage.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 5/29/24.
//

import CoreData

public final class CoreDataStorage {
    static let shared = CoreDataStorage()
    
    private let persistentContainer: NSPersistentContainer
    
    public init(inMemory: Bool = false) {
        guard let modelURL = Bundle.module.url(forResource: "Cafe", withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Cannot find Cafe.momd")
        }
        
        let container = NSPersistentContainer(
            name: "Cafe",
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
