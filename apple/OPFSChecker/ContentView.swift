//
//  ContentView.swift
//  OPFSChecker
//
//  Created by Maximilian Alexander on 10/22/24.
//

import SwiftUI
import WebKit

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var webView: WKWebView?
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            // Handle absolute URLs (like external links)
            if url.scheme == "http" || url.scheme == "https" {
                // Open external links in Safari
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
            
            // Handle local asset requests
            if url.path.starts(with: "/assets/") {
                if let assetURL = Bundle.main.url(forResource: String(url.path.dropFirst()), withExtension: nil) {
                    webView.load(URLRequest(url: assetURL))
                    decisionHandler(.cancel)
                    return
                }
            }
        }
        decisionHandler(.allow)
    }
}

struct WebView: UIViewRepresentable {
    let coordinator = WebViewCoordinator()
    
    func makeCoordinator() -> WebViewCoordinator {
        coordinator
    }
    
    func makeUIView(context: Context) -> WKWebView {
        // Configure WKWebView
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        coordinator.webView = webView
        
        // Allow file access
        webView.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        webView.configuration.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        
        // Load the index.html file
        if let distURL = Bundle.main.url(forResource: "dist/index", withExtension: "html") {
            let baseURL = distURL.deletingLastPathComponent()
            
            do {
                let htmlString = try String(contentsOf: distURL, encoding: .utf8)
                // Modify paths to be relative
                let modifiedHTML = htmlString
                    .replacingOccurrences(of: "src=\"/assets/", with: "src=\"assets/")
                    .replacingOccurrences(of: "href=\"/assets/", with: "href=\"assets/")
                
                webView.loadHTMLString(modifiedHTML, baseURL: baseURL)
            } catch {
                let errorHTML = """
                    <html><body>
                        <h1>Error</h1>
                        <p>Could not load the web content: \(error.localizedDescription)</p>
                    </body></html>
                """
                webView.loadHTMLString(errorHTML, baseURL: nil)
            }
        } else {
            let errorHTML = """
                <html><body>
                    <h1>Error</h1>
                    <p>Could not find index.html in the dist folder.</p>
                </body></html>
            """
            webView.loadHTMLString(errorHTML, baseURL: nil)
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update logic if needed
    }
}

struct ContentView: View {
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            WebView()
                .onAppear {
                    isLoading = false
                }
            
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
