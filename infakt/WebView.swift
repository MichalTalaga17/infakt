//
//  WebView.swift
//  infakt
//
//  Created by Michał Talaga on 07/07/2025.
//


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator

        let request = URLRequest(url: url)
        webView.load(request)

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            webView.evaluateJavaScript("""
            (function() {
                for (let i = 0; i < sessionStorage.length; i++) {
                    let key = sessionStorage.key(i);
                    if (key.endsWith('.clientId')) {
                        return sessionStorage.getItem(key);
                    }
                }
                return null;
            })()
            """) { result, error in
                if let error = error {
                    print("⚠️ Błąd sessionStorage: \(error.localizedDescription)")
                    print("URL: \(webView.url?.absoluteString ?? "brak URL")")
                    return
                }
                if let clientId = result as? String, !clientId.isEmpty {
                    print("✅ Zalogowano, clientId: \(clientId)")
                    print("URL: \(webView.url?.absoluteString ?? "brak URL")")
                } else {
                    print("❌ Nie zalogowano (brak .clientId w sessionStorage)")
                    print("URL: \(webView.url?.absoluteString ?? "brak URL")")
                }

            }
        }
    }

}
