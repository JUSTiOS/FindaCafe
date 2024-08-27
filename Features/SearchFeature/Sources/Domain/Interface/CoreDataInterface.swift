import CommonCoreData

protocol CoreDataInterface {
    func fetchCafes() async throws -> [Cafe]
    func addCafe(_ cafe: Cafe) async throws
    func updateCafe(_ cafe: Cafe) async throws
    func deleteCafe(_ cafe: Cafe) async throws
}
