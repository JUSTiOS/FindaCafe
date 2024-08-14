protocol CoreDataInterface {
    func getCafeInfo() -> Result<CafeInfo, CoreDataError>
    
    func deleteCafeInfo() -> Result<Bool, CoreDataError>
    
    func updateCafeInfo(
        vibe: String,
        toilet: String,
        storeSize: String,
        powerSocket: String,
        etc: String,
        congestion: String
    ) -> Result<Bool, CoreDataError>
    
    func addCafeInfo(
        vibe: String,
        toilet: String,
        storeSize: String,
        powerSocket: String,
        etc: String,
        congenstion: String,
        phone: String,
        logitude: String,
        latitude: String,
        distance: String,
        categoryName: String,
        cafeName: String,
        address: String
    ) -> Result<Bool, CoreDataError>
}
