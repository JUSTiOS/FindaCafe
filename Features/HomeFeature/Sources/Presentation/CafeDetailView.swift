//
//  CafeDetailView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/6/24.
//

import SwiftUI
import WebKit

struct CafeDetailView: View {
    @State private var showsTagEditSheet: Bool = false
    @State private var showsWebViewSheet: Bool = false
    var cafe: Cafe
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(cafe.name)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "star")
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
            
            HStack {
                Text("주소:")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                
                Text(cafe.address)
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("연락처:")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                
                Text(cafe.phone)
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("태그: ")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                
                ForEach(Array(cafe.tags), id: \.self) { tag in
                    TagView(tag: tag)
                }
                
                Spacer()
                
                Button(action: {
                    showsTagEditSheet = true
                }) {
                    Text("태그 수정")
                        .font(.system(size: 9))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 7)
                }
                .foregroundStyle(.white)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            HStack {
                Text("위치")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            GeometryReader { proxy in
                MapView(size: proxy.size, position: cafe.coord)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .frame(maxHeight: 250)
            .padding(.horizontal)
            
            Button(action: {
                showsWebViewSheet = true
            }) {
                Text("상세 보기")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.white)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
            Spacer()
        }
        .padding(.horizontal)
        .sheet(isPresented: $showsWebViewSheet, onDismiss: {
            showsWebViewSheet = false
        }) {
            WebView(url: URL(string: cafe.placeURL)!)
        }
        .sheet(isPresented: $showsTagEditSheet, onDismiss: { showsTagEditSheet = false }) {
            TagEditView()
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
