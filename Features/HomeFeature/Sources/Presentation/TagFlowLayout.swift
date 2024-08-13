//
//  TagFlowLayout.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 8/2/24.
//

import SwiftUI

struct TagFlowLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var totalWidth: CGFloat = .zero
        var totalHeight: CGFloat = .zero
        var lineWidth: CGFloat = .zero
        var lineHeight: CGFloat = .zero
        
        for size in sizes {
            if lineWidth + size.width > proposal.width ?? .zero {
                totalHeight += lineHeight
                lineWidth = size.width
                lineHeight = size.height
            } else {
                lineWidth += size.width
                lineHeight = max(lineHeight, size.height)
            }
            
            totalWidth = max(totalWidth, lineWidth)
        }
        
        totalHeight += lineHeight
        
        return .init(width: totalWidth, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = .zero
        
        for index in subviews.indices {
            if lineX + sizes[index].width > (proposal.width ?? .zero) {
                lineY += lineHeight
                lineHeight = .zero
                lineX = bounds.minX
            }
            
            subviews[index].place(
                at: .init(
                    x: lineX + sizes[index].width / 2,
                    y: lineY + sizes[index].height / 2
                ),
                anchor: .center,
                proposal: ProposedViewSize(sizes[index])
            )
            
            lineHeight = max(lineHeight, sizes[index].height)
            lineX += sizes[index].width
        }
        
    }
}
