//
//  TagView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 7/9/24.
//

import SwiftUI

struct TagView: View {
    private let tag: Tag
    
    init(tag: Tag) {
        self.tag = tag
    }
    
    var body: some View {
        Text(tag.name)
            .font(.system(size: 9))
            .fontWeight(.bold)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
            )
    }
}
