//
//  WebViewScreen.swift
//  iOS-FakeNFT-Extended
//
//  Created by Вадим Суханов on 16.12.2025.
//

import SwiftUI
import WebKit

// MARK: - Screen

struct WebViewScreen: View {
    let url: URL?

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
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - WebView

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

// MARK: - Preview

#Preview("WebViewScreen") {
    NavigationStack {
        WebViewScreen(url: URL(string: "https://www.google.com"))
    }
}
