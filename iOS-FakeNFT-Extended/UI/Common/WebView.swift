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
    let fallbackURL: URL?

    func makeCoordinator() -> Coordinator {
        Coordinator(fallbackURL: fallbackURL)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    final class Coordinator: NSObject, WKNavigationDelegate {
        let fallbackURL: URL?
        private var didFallback = false

        init(fallbackURL: URL?) {
            self.fallbackURL = fallbackURL
        }

        private func fallback(_ webView: WKWebView, error: Error) {
            guard
                !didFallback,
                let fallbackURL
            else { return }

            didFallback = true
            print("WebView failed, fallback:", error)
            webView.load(URLRequest(url: fallbackURL))
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation!,
            withError error: Error
        ) {
            fallback(webView, error: error)
        }

        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation!,
            withError error: Error
        ) {
            fallback(webView, error: error)
        }
    }
}

struct WebViewScreen: View {
    let url: URL?
    @Environment(\.dismiss) private var dismiss

    private let fallbackURL = URL(string: "https://practicum.yandex.ru/ios-developer/")

    var body: some View {
        Group {
            if let url {
                WebView(url: url, fallbackURL: fallbackURL)
            } else if let fallbackURL {
                WebView(url: fallbackURL, fallbackURL: nil)
            } else {
                Text("Не удалось открыть страницу")
            }
        }
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
    if
        let url = URL(string: "https://apple.com"),
        let fallbackURL = URL(string: "https://practicum.yandex.ru/ios-developer/")
    {
        WebView(url: url, fallbackURL: fallbackURL)
            .frame(height: 300)
    } else {
        Text("Invalid preview URLs")
    }
}
