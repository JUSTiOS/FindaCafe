import SwiftUI
import KakaoMapsSDK

public struct CafeMapView: View {
    @State var draw: Bool = false
    @State private var searchText: String = ""
    
    public init() {
        SDKInitializer.InitSDK(appKey: "d8467343ae24e33349cee732be690103")
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            KakaoMapView(draw: $draw).onAppear(perform: {
                self.draw = true
            }).onDisappear(perform: {
                self.draw = false
            }).ignoresSafeArea()
            
            Searchbar(searchText: $searchText)
                .padding()
        }
    }
}
