import SwiftUI

enum Tab: String, CaseIterable {
    case myCafe = "heart.text.square"
    case searchCafe = "magnifyingglass"
    case info = "info.circle"
}

struct CustomTabbar: View {
    @Binding var selectedTab: Tab
    
    private var fillImage: String {
        if selectedTab != .searchCafe {
            selectedTab.rawValue + ".fill"
        } else {
            selectedTab.rawValue
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "heart.text.square")
                    .scaleEffect(selectedTab == .myCafe ? 1.5 : 1.25)
                Text("내 카페")
                    .font(.system(size: 12))
                    .padding(.top, 5)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedTab == .myCafe ? .black : .gray)
            .onTapGesture {
                withAnimation {
                    selectedTab = .myCafe
                }
            }
            Spacer()
            VStack {
                Image(systemName: "magnifyingglass")
                    .scaleEffect(selectedTab == .searchCafe ? 1.5 : 1.25)
                Text("카페 찾기")
                    .font(.system(size: 12))
                    .padding(.top, 5)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedTab == .searchCafe ? .black : .gray)
            .onTapGesture {
                withAnimation {
                    selectedTab = .searchCafe
                }
            }
            Spacer()
            VStack {
                Image(systemName: "info.circle")
                    .scaleEffect(selectedTab == .info ? 1.5 : 1.25)
                Text("정보")
                    .font(.system(size: 12))
                    .padding(.top, 5)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedTab == .info ? .black : .gray)
            .onTapGesture {
                withAnimation {
                    selectedTab = .info
                }
            }
            Spacer()
        }
        .padding(.top)
        .padding(.bottom)
        .background(.white)
        .clipShape(
            .rect(
                topLeadingRadius: 25,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 25)
        )
        .shadow(radius: 5)
        .mask(Rectangle().padding(.top, -10))
    }
}
