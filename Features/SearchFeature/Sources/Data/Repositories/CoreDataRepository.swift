public final class CoreDataRepository: CoreDataInterface {
    let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
}

extension CoreDataRepository {
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
    ) -> Result<Bool, CoreDataError> {
        return coreDataService.addCafeInfo(
            vibe: vibe,
            toilet: toilet,
            storeSize: storeSize,
            powerSocket: powerSocket,
            etc: etc,
            congestion: congenstion,
            phone: phone,
            longitude: logitude,
            latitude: latitude,
            distance: distance,
            categoryName: categoryName,
            cafeName: cafeName,
            address: address
        )
    }
    
    func getCafeInfo() -> Result<CafeInfo, CoreDataError> {
        return coreDataService.fetchCafeInfo()
    }
    
    func updateCafeInfo(
        vibe: String,
        toilet: String,
        storeSize: String,
        powerSocket: String,
        etc: String,
        congestion: String
    ) -> Result<Bool, CoreDataError> {
        return coreDataService.updateCafeInfo(
            vibe: vibe,
            toilet: toilet,
            storeSize: storeSize,
            powerSocket: powerSocket,
            etc: etc,
            congestion: congestion
        )
    }
    
    func deleteCafeInfo() -> Result<Bool, CoreDataError> {
        return coreDataService.deleteCafeInfo()
    }
}
