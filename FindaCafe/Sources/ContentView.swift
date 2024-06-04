import SwiftUI
import SearchFeature

public struct ContentView: View {
    public init() {}

    public var body: some View {
        TabView {
            Text("First").tabItem {
                Image(systemName: "heart.text.square")
                Text("내 카페")
            }
            SearchFeature.CafeMapView().tabItem {
                Image(systemName: "magnifyingglass")
                Text("카페 찾기")
            }
            Text("Third").tabItem {
                Image(systemName: "info.circle")
                Text("정보")
            }
        }
        .background(Color.red)
        .cornerRadius(30)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
