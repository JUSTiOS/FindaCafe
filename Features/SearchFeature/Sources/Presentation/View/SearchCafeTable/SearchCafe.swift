import SwiftUI

struct SearchCafe: View {
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("스타벅스")
                    Spacer()
                    Text("300m")
                }.frame(height: 40)
            }
            .listStyle(.plain)
        }
    }
}
