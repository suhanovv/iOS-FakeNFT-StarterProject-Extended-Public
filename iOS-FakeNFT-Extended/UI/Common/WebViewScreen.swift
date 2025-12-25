import SwiftUI
import WebKit

struct WebViewScreen: View {
    let url: URL
    var body: some View {
        WebView(url: url)
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}


#Preview {
    WebViewScreen(url: URL(string: "https://www.google.com")!)
}
