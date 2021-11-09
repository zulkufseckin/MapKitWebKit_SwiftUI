//
//  WebView.swift
//  MapKitWebKit
//
//  Created by Zülküf Seçkin on 9.09.2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let url: URL?
    
    var activity = UIActivityIndicatorView()
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = context.coordinator
        
        self.activity.style = .large
        self.activity.startAnimating()
        self.activity.hidesWhenStopped = true
        self.activity.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        
        webView.addSubview(self.activity)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = url else { return  }
        
        let request = URLRequest(url: url)
        uiView.load(request)
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
            
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                if url.host != "www.google.com" {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
        
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.parent.activity.stopAnimating()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.activity.stopAnimating()
        }
        
    }
    
}
