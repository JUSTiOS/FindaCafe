import SwiftUI

struct Searchbar: View {
    @Binding var searchText: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("내 주변 카페 검색", text: $searchText) {
                
            }
        }
        .padding()
        .background(Color.white)
        .overlay {
            Rectangle()
                .stroke(lineWidth: 2)
                .cornerRadius(15)
        }
    }
}
