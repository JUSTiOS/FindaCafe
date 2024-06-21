//
//  TagEditView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/19/24.
//

import SwiftUI

struct TagEditView: View {
//    @Binding var selectedTags: Set<Tag>
    @State private var newCustomTagName: String = ""
    
    var body: some View {
        VStack {
            Text("태그 수정")
                .font(.system(size: 17))
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("태그 설정")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .padding(.bottom)
                
//                Text("설정된 태그")
//                    .font(.system(size: 10))
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.gray)
                
                Text("분위기")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                
                HStack {
                    TagView(tag: Tag(name: "조용함", category: .mood))
                    TagView(tag: Tag(name: "적당함", category: .mood))
                    TagView(tag: Tag(name: "활기참", category: .mood))
                    TagView(tag: Tag(name: "소란스러움", category: .mood))
                }
                .padding(.bottom, 8)
                
                Text("매장 크기")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                
                HStack {
                    TagView(tag: Tag(name: "작음", category: .cafeSize))
                    TagView(tag: Tag(name: "적당함", category: .cafeSize))
                    TagView(tag: Tag(name: "넓음", category: .cafeSize))
                }
                .padding(.bottom, 8)
                
                Text("혼잡도")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                
                HStack {
                    TagView(tag: Tag(name: "원활", category: .congestion))
                    TagView(tag: Tag(name: "보통", category: .congestion))
                    TagView(tag: Tag(name: "혼잡", category: .congestion))
                }
                .padding(.bottom, 8)
                
                Text("콘센트 유무")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                
                HStack {
                    TagView(tag: Tag(name: "있음", category: .powerOutlet))
                    TagView(tag: Tag(name: "없음", category: .powerOutlet))
                }
                .padding(.bottom, 8)
                
                Text("매장 내 화장실 유무")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                
                HStack {
                    TagView(tag: Tag(name: "있음", category: .toilet))
                    TagView(tag: Tag(name: "없음", category: .toilet))
                }
                .padding(.bottom, 8)
                
                Text("기타")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                
                HStack {
                    TextField("태그를 입력해 주세요", text: $newCustomTagName)
                        .padding(.horizontal, 24)
                        .padding(.vertical)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 2)
                        )
                    
                    Button(action: {
                        
                    }) {
                        Text("입력")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .padding(.horizontal, 24)
                            .padding(.vertical)
                    }
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.bottom, 8)
                
                Button(action: {
                    
                }) {
                    Text("수정 완료")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .padding(.horizontal, 24)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                }
                .foregroundStyle(.white)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
        }
        .padding()
    }
}

//#Preview {
//    TagEditView()
//}
