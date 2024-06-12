import SwiftUI
import SearchFeature

public struct ContentView: View {
    @State private var selectedTab: Tab = .myCafe
    public var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab){
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        HStack {
                            if tab == .searchCafe {
                                SearchFeature.CafeMapView()
                            } else {
                                    VStack {
                                    Image(systemName: tab.rawValue)
                                    Text("")
                                }
                            }
                        }
                        .tag(tab)
                    }
                }
            }
            
            VStack {
                Spacer()
                CustomTabbar(selectedTab: $selectedTab)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .ignoresSafeArea()
    }
}
