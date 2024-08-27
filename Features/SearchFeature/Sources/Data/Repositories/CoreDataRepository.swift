import CommonCoreData

public final class CoreDataRepository: CoreDataInterface {
    let coreDataManager: CoreDataProtocol
    
    init(coreDataManager: CoreDataProtocol) {
        self.coreDataManager = coreDataManager
    }
}

extension CoreDataRepository {
    func fetchCafes() async throws -> [Cafe] {
        try await coreDataManager.fetchCafes()
    }
    
    func addCafe(_ cafe: Cafe) async throws {
        try await coreDataManager.addCafe(cafe)
    }
    
    func updateCafe(_ cafe: Cafe) async throws {
        try await coreDataManager.updateCafe(cafe)
    }
    
    func deleteCafe(_ cafe: Cafe) async throws {
        try await coreDataManager.deleteCafe(cafe)
    }
}
