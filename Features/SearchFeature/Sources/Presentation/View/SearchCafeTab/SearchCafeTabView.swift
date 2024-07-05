import SwiftUI
import KakaoMapsSDK
import Combine

public struct SearchCafeTabView: View {
    @ObservedObject var searchCafeTabViewModel: SearchCafeTabViewModel
    @ObservedObject var searchCafeTableViewModel: SearchCafeTableViewModel
    @FocusState private var isFocused: Bool
    @State var coordinator: KakaoMapCoordinator = KakaoMapCoordinator()
    
    public init(searchCafeTabViewModel: SearchCafeTabViewModel, searchCafeTableViewModel: SearchCafeTableViewModel) {
        self.searchCafeTabViewModel = searchCafeTabViewModel
        self.searchCafeTableViewModel = searchCafeTableViewModel
        
        if let apiKey = Bundle.main.authAPIKey {
            SDKInitializer.InitSDK(appKey: apiKey)
        } else {
            //alert
        }
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            VStack{
                if searchCafeTabViewModel.update {
                    KakaoMapView(coordinator: $coordinator, location: searchCafeTabViewModel.myLocation, nearbyCafes: searchCafeTabViewModel.nearbyCafes, draw: searchCafeTabViewModel.draw)
                        .environmentObject(searchCafeTabViewModel.myLocation)
                        .onAppear {
                            searchCafeTabViewModel.draw = true
                        }.onDisappear {
                            searchCafeTabViewModel.draw = false
                        }.ignoresSafeArea(edges: .top)
                }
            }
            
            VStack {
                Searchbar(searchText: searchCafeTabViewModel.$searchText)
                    .focused($isFocused)
                    .autocorrectionDisabled(true)
                    .padding()
                if isFocused {
                    SearchCafeTable(viewModel: searchCafeTableViewModel, myLocation: searchCafeTabViewModel.myLocation)
                } else {
                    HStack {
                        Spacer()
                        Button {
                            coordinator.moveCamera()
                        } label: {
                            Image(systemName: "dot.scope")
                                .font(.system(size: 25))
                        }
                        .frame(width: 50, height: 50)
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.top, -5)
                        .padding(.trailing)
                        .shadow(radius: 3)
                    }}
                Spacer()
            }
            .background(isFocused ? .white : .clear)
            .onAppear {
                searchCafeTabViewModel.getMyLocation()
                searchCafeTabViewModel.getNearbyCafeList()
            }
        }
    }
}
