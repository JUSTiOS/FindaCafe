import SwiftUI

struct CafeDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var bookMarkSelected: Bool = false
     
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("요거트 아이스크림의 정석")
                        .font(.system(size: 22))
                        .fontWeight(.heavy)
                    Spacer()
                    Button {
                        bookMarkSelected.toggle()
                    } label: {
                        Image(systemName: bookMarkSelected ? "star.fill" : "star")
                            .tint(.black)
                            .font(.system(size: 20))
                    }
                }
                Text("서울특별시 강남구 봉은사로2길 39")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                Divider()
                HStack {
                    Image(systemName: "map")
                        .tint(.black)
                        .font(.system(size: 16))
                    Text("지도")
                        .font(.system(size: 16))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                Rectangle()
                    .frame(height: 200)
                    .foregroundColor(.gray)
                    .cornerRadius(20)
                    .padding([.top, .bottom])
                Divider()
                HStack {
                    Image(systemName: "tag")
                        .tint(.black)
                        .font(.system(size: 16))
                    Text("태그")
                        .font(.system(size: 16))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                Text("분위기")
                    .font(.system(size: 14))
                    .tint(.gray)
                Text("매장크기")
                    .font(.system(size: 14))
                    .tint(.gray)
                Text("혼잡도")
                    .font(.system(size: 14))
                    .tint(.gray)
                Text("콘센트 유무")
                    .font(.system(size: 14))
                    .tint(.gray)
                Text("화장실 유무")
                    .font(.system(size: 14))
                    .tint(.gray)
                Text("기타")
                    .font(.system(size: 14))
                    .tint(.gray)
                HStack(alignment: .center) {
                    Button {
                        dismiss()
                    } label: {
                        Text("수정 완료")
                            .tint(.white)
                            .bold()
                    }
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    .frame(height: 50)
                    .background(.black)
                    .cornerRadius(15)
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "chevron.backward")
                }
            }
        }
    }
    
}
