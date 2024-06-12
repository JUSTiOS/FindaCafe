import SwiftUI

struct Searchbar: View {
    @Binding var searchText: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            Spacer()
            
            ZStack {
                HStack {
                    TextField("내 주변 카페 검색", text: $searchText) {
                        
                    }
                    .focused($isFocused)
                }
                
                HStack {
                    if isFocused {
                        Spacer()
                        Button {
                            isFocused.toggle()
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
