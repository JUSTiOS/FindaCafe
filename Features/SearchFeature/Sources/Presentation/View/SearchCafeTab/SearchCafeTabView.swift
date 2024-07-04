import SwiftUI
import KakaoMapsSDK
import Combine

public struct SearchCafeTabView: View {
    @ObservedObject var viewModel: SearchCafeTabViewModel
    @FocusState private var isFocused: Bool
    @State var coordinator: KakaoMapCoordinator = KakaoMapCoordinator()
    
    public init(viewModel: SearchCafeTabViewModel) {
        self.viewModel = viewModel
        
        if let apiKey = Bundle.main.authAPIKey {
            SDKInitializer.InitSDK(appKey: apiKey)
        } else {
            //alert
        }
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            VStack{
                if viewModel.update {
                    KakaoMapView(coordinator: $coordinator, location: viewModel.myLocation, nearbyCafes: viewModel.nearbyCafes, draw: viewModel.draw)
                        .environmentObject(viewModel.myLocation)
                        .onAppear {
                            viewModel.draw = true
                        }.onDisappear {
                            viewModel.draw = false
                        }.ignoresSafeArea(edges: .top)
                }
            }
            
            VStack {
                Searchbar(searchText: viewModel.$searchText)
                    .focused($isFocused)
                    .autocorrectionDisabled(true)
                    .padding()
                if isFocused {
                    SearchCafeTable()
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
                viewModel.getMyLocation()
                viewModel.getNearbyCafeList()
            }
        }
    }
}
