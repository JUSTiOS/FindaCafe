import SwiftUI
import KakaoMapsSDK
import Combine

public struct CafeMapView: View {
    @State var draw: Bool = false
    @State private var searchText: String = ""
    @FocusState private var isFocused: Bool
    @State var locationService = LocationSevice()
    
    public init() {
        SDKInitializer.InitSDK(appKey: "d8467343ae24e33349cee732be690103")
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            VStack{
                KakaoMapView(draw: $draw).onAppear(perform: {
                    self.draw = true
                }).onDisappear(perform: {
                    self.draw = false
                })
                .ignoresSafeArea(edges: .top)
            }
            
            VStack {
                Searchbar(searchText: $searchText)
                    .focused($isFocused)
                    .autocorrectionDisabled(true)
                    .padding()
                
                if isFocused {
                    SearchCafe()
                } else {
                    HStack {
                        Spacer()
                        
                        Button {
                            // 지도 현재위치로
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
        }
    }
}
