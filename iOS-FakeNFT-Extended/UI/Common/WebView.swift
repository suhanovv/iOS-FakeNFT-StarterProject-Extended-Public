//
//  WebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Diana Viter on 09.12.2025.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Environment(\.dismiss) private var dismiss

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct WebViewScreen: View {
    let url: URL
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        WebView(url: url)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - Previews

#Preview("WebView Preview") {
    WebView(url: URL(string: "https://apple.com")!)
        .frame(height: 300)
}

#Preview("WebViewScreen Preview") {
    NavigationStack {
        WebViewScreen(url: URL(string: "https://apple.com")!)
    }
}
