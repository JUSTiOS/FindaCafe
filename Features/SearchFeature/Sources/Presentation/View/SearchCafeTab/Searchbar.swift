import SwiftUI

struct Searchbar: View {
    @FocusState private var searchbarFocused: Bool
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            Spacer()
            
            ZStack {
                HStack {
                    TextField("내 주변 카페 검색", text: $searchText) {
                        
                    }
                    .focused($searchbarFocused)
                }
                HStack {
                    if searchbarFocused {
                        Spacer()
                        Button {
                            searchbarFocused.toggle()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 3)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
        }
    }
}
