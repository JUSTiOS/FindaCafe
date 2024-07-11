import SwiftUI

struct BottomSheetView: View {
    var cafeEntity: NearbyCafeEntity
    
    @Binding var coordinator: KakaoMapCoordinator
    @State private var bookMarkSelected: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cafeEntity.cafeName)
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                Spacer()
                Button {
                    bookMarkSelected.toggle()
                } label: {
                    Image(systemName: bookMarkSelected ? "star.fill" : "star")
                        .tint(.black)
                        .font(.system(size: 25))
                }
            }
            .padding(.bottom, 4)
            Text(cafeEntity.address)
                .font(.system(size: 14))
                .foregroundStyle(.gray)
            
                .padding(.bottom, 4)
            Spacer()
            HStack {
                Text("# 태그 없음")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                Spacer()
                NavigationLink {
                    CafeDetailView()
                } label: {
                    Text("태그 수정")
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 20)
                .font(.system(size: 14))
                .background(.black)
                .foregroundStyle(.white)
                .cornerRadius(15)
            }
        }
        .padding(.top, 30)
        .padding([.leading, .trailing, .bottom], 30)
    }
}
