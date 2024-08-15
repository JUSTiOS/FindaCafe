public class AppDI: AppDIInterface {
    public static let shared = AppDI()
    
    public func searchCafeTabDependencies() -> SearchCafeTabViewModel {
        let myLocationService = NowLocationSevice()
        let myLocationRepository = MyLocationRepository(nowLocationService: myLocationService)
        let myLocationUsecase = NowLocationUseCase(repository: myLocationRepository)
        
        let networkService = NetworkService()
        let nearbyCafeRepository = NearbyCafeRepository(networkService: networkService)
        let nearbyCafeUsecase = NearbyCafeUsecase(repository: nearbyCafeRepository)
        
        let viewModel = SearchCafeTabViewModel(myLocationUseCase: myLocationUsecase, nearbyCafeUseCase: nearbyCafeUsecase)
        
        return viewModel
    }
    
    public func searchCafeTableDependencies() -> SearchCafeTableViewModel {
        let networkService = NetworkService()
        let nearbyCafeRepository = NearbyCafeRepository(networkService: networkService)
        let nearbyCafeUsecase = NearbyCafeUsecase(repository: nearbyCafeRepository)
        
        let viewModel = SearchCafeTableViewModel(nearbyCafeUsecase: nearbyCafeUsecase)
        
        return viewModel
    }
}
