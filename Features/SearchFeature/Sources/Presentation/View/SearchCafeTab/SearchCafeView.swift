import SwiftUI
import KakaoMapsSDK
import Combine

public struct SearchCafeTabView: View {
    @ObservedObject var viewModel: SearchCafeTabViewModel
    @ObservedObject var location: MyLocationEntity
    @FocusState private var isFocused: Bool
    @State var coordinator: KakaoMapCoordinator = KakaoMapCoordinator()
    
    public init(viewModel: SearchCafeTabViewModel) {
        self.viewModel = viewModel
        self.location = viewModel.myLocation
        SDKInitializer.InitSDK(appKey: "")
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            VStack{
                if viewModel.myLocation.longitude != 0.0 {
                    KakaoMapView(coordinator: $coordinator, draw: viewModel.draw)
                        .environmentObject(location)
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
                    SearchCafe()
                } else {
                    HStack {
                        Spacer()
                        Button {
                            print("viewModel.draw = ", viewModel.draw)
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
                location.latitude = viewModel.myLocation.latitude
                location.longitude = viewModel.myLocation.longitude
            }
        }
    }
}
