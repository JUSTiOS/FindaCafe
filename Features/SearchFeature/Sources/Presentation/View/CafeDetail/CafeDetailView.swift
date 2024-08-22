import SwiftUI

struct CafeDetailView: View {
    @Environment(\.dismiss) var dismiss
    var cafeEntity: NearbyCafeEntity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CafeDetailTitle(cafeEntity: cafeEntity)
                CafeDetailMap(cafeEntity: cafeEntity)
                CafeDetailTag()
            }
        }
        .scrollIndicators(.hidden)
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
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

struct CafeDetailTitle: View {
    @State var bookMarkSelected: Bool = false
    var cafeEntity: NearbyCafeEntity
    
    var body: some View {
        HStack {
            Text(cafeEntity.cafeName)
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
        .padding(.bottom, 5)
        Text(cafeEntity.address)
            .font(.system(size: 14))
            .foregroundStyle(.gray)
        Text(cafeEntity.phone)
            .font(.system(size: 14))
            .foregroundStyle(.gray)
        Divider()
    }
}

struct CafeDetailMap: View {
    @State var draw: Bool = false
    
    var coordinator: KakaoMapCoordinator = KakaoMapCoordinator()
    var cafeEntity: NearbyCafeEntity
    
    var body: some View {
        HStack {
            Image(systemName: "map")
                .tint(.black)
                .font(.system(size: 16))
            Text("지도")
                .font(.system(size: 16))
                .fontWeight(.heavy)
        }
        .padding(.top)
        
        KakaoMapView(coordinator: coordinator, draw: $draw, myLocation: nil, nearbyCafes: [cafeEntity])
            .frame(height: 200)
            .foregroundColor(.gray)
            .cornerRadius(15)
            .padding([.top, .bottom])
            .onAppear {
                draw = true
            }.onDisappear {
                draw = false
            }
            .allowsHitTesting(false)
        
        Divider()
    }
}

struct CafeDetailTag: View {
    @Environment(\.dismiss) var dismiss
    @State var customTag: String = ""

    var body: some View {
        HStack {
            Image(systemName: "tag")
                .tint(.black)
                .font(.system(size: 16))
            Text("태그")
                .font(.system(size: 16))
                .fontWeight(.heavy)
        }
        .padding([.top, .bottom])
        
        TagSection(viewModel: TagSectionViewModel(sectionTitle: "분위기", sectionItems: ["조용함", "적당함", "활기참", "소란스러움"]))
        TagSection(viewModel: TagSectionViewModel(sectionTitle: "매장 크기", sectionItems: ["작음", "적당함", "넓음"]))
        TagSection(viewModel: TagSectionViewModel(sectionTitle: "혼잡도", sectionItems: ["원활", "보통", "혼잡"]))
        TagSection(viewModel: TagSectionViewModel(sectionTitle: "콘센트 유무", sectionItems: ["있음", "없음"]))
        TagSection(viewModel: TagSectionViewModel(sectionTitle: "화장실 유무", sectionItems: ["없음", "있음"]))
        
        HStack {
            TextField("태그를 입력하세요.", text: $customTag){
                
            }
            .padding(.leading, 8)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
            }
            .padding(4)
            
            Button{
                
            } label: {
                Text("입력")
                    .tint(.white)
                    .frame(width: 100, height: 50)
                    .background(.black)
                    .cornerRadius(15)
            }
        }
        
        HStack {
            Button {
                dismiss()
            } label: {
                Text("수정 완료")
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.black)
                    .cornerRadius(15)
            }
            .padding(.bottom, 30)
        }
    }
}
