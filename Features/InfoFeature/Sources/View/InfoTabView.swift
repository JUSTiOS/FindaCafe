import SwiftUI

public struct InfoTabView: View {
    @State private var guideSection = [
        InfoList(id: .faq,title: "FAQ"),
        InfoList(id: .userGuide, title: "사용 가이드 북 보기"),
        InfoList(id: .opensourceLicense, title: "오픈소스 라이센스")
    ]
    
    @State private var askSection = [
        InfoList(id: .ask, title: "문의하기")
    ]
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            VStack {
                Text("정보")
                    .bold()
                    .padding()
                
                List {
                    Section {
                        ForEach(guideSection) { guide in
                            InfoListView(list: guide)
                        }
                    } header: {
                        HStack {
                            Text("안내")
                                .foregroundStyle(.black)
                                .font(.system(size: 16))
                                .bold()
                                .padding(.bottom)
                            Spacer()
                        }
                    }
                }
                .padding([.leading, .trailing])
                .listStyle(.plain)
                .scrollDisabled(true)
                .frame(height: 200)
                
                List {
                    Section {
                        ForEach(askSection) { ask in
                            InfoListView(list: ask)
                        }
                    } header: {
                        HStack {
                            Text("문의")
                                .foregroundStyle(.black)
                                .font(.system(size: 16))
                                .bold()
                                .padding(.bottom)
                        }
                    }
                }
                
                .padding([.leading, .trailing])
                .listStyle(.plain)
                .scrollDisabled(true)
                .frame(height: 120)
                
                Text("v.1.0")
                    .foregroundStyle(.gray)
                
                Spacer()
            }
        }
        
    }
}
