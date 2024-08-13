//
//  CafeListCellView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 7/1/24.
//

import SwiftUI

struct CafeListCellView: View {
    @Binding var cafe: Cafe
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(.brown)
                .frame(width: 85, height: 85)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(cafe.name)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(cafe.address)
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .padding(.bottom, 8)
                
                HStack(spacing: 0) {
                    ForEach(Array(cafe.tags), id: \.self) { tag in
                        TagView(tag: tag)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 4)
                    }
                }
                
//                TagFlowLayout {
//                    ForEach(cafe.tags, id: \.self) { tag in
//                        TagView(tag: tag)
//                            .padding(.horizontal, 4)
//                            .padding(.vertical, 4)
//                    }
//                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
            
            Spacer()
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.5)
        )
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 3, x: 3, y: 3)
        )
    }
}
