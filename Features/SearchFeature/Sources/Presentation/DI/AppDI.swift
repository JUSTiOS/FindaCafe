public class AppDI: AppDIInterface {
    public static let shared = AppDI()
    
    public func cafeMapDependencies() -> CafeMapViewModel {
        let locationService = NowLocationSevice()
        let repository = NowLocationRepository(nowLocationService: locationService)
        let useCase = NowLocationUseCase(repository: repository)
        let viewModel = CafeMapViewModel(myLocationUseCase: useCase)
        return viewModel
    }
}
