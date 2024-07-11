import SwiftUI
import KakaoMapsSDK
import Combine

public struct SearchCafeTabView: View {
    @ObservedObject private var searchCafeTabViewModel: SearchCafeTabViewModel
    @ObservedObject private var searchCafeTableViewModel: SearchCafeTableViewModel
    @FocusState private var searchbarFocused: Bool
    @State private var coordinator: KakaoMapCoordinator = KakaoMapCoordinator()
    @State private var cafeSelected: Bool = false
    @State private var draw: Bool = false
    
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
        NavigationView {
            ZStack(alignment: .top) {
                VStack{
                    if searchCafeTabViewModel.downloadFinish {
                        KakaoMapView(coordinator: $coordinator, draw: $draw, location: searchCafeTabViewModel.myLocation, nearbyCafes: searchCafeTabViewModel.nearbyCafes)
                            .environmentObject(searchCafeTabViewModel.myLocation)
                            .onTapGesture {
                                cafeSelected = false
                            }
                            .onAppear {
                                draw = true
                            }.onDisappear {
                                draw = false
                            }.ignoresSafeArea(edges: .top)
                    }
                }
                
                VStack {
                    Searchbar(searchText: searchCafeTabViewModel.$searchText)
                        .focused($searchbarFocused)
                        .autocorrectionDisabled(true)
                        .padding()
                    
                    if searchbarFocused {
                        SearchCafeTable(viewModel: searchCafeTableViewModel, coordinator: $coordinator, isFocused: _searchbarFocused, cafeSelected: $cafeSelected, myLocation: searchCafeTabViewModel.myLocation)
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
                        }
                        
                        if cafeSelected {
                            GeometryReader { geometry in
                                VStack {
                                    Spacer()
                                    BottomSheetView(cafeEntity: searchCafeTableViewModel.selectedCafe, coordinator: $coordinator)
                                        .frame(height: geometry.size.height / 3)
                                        .background(Color.white)
                                        .cornerRadius(25)
                                        .offset(y: cafeSelected ? 0 : geometry.size.height / 4)
                                        .animation(.easeInOut)
                                }
                                .edgesIgnoringSafeArea(.bottom)
                                .padding([.leading, .trailing], 10)
                                .padding(.bottom, 30)
                            }
                            .shadow(radius: 3)
                            .transition(.move(edge: .bottom))
                        }
                        
                    }
                    
                    Spacer()
                }
                .background(searchbarFocused ? .white : .clear)
                .onAppear {
                    searchCafeTabViewModel.getMyLocation()
                    searchCafeTabViewModel.getNearbyCafeList()
                    
                    cafeSelected = false
                }
            }
            .animation(nil)
        }
        .tint(.black)
    }
}

