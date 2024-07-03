public class AppDI: AppDIInterface {
    public static let shared = AppDI()
    
    public func searchCafeTabDependencies() -> SearchCafeTabViewModel {
        let locationService = NowLocationSevice()
        let repository = MyLocationRepository(nowLocationService: locationService)
        let useCase = NowLocationUseCase(repository: repository)
        let viewModel = SearchCafeTabViewModel(myLocationUseCase: useCase)
        return viewModel
    }
}
