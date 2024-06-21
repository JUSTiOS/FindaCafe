//
//  WebView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/11/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
