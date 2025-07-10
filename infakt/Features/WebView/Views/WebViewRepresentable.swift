//
//  WebViewRepresentable.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
    
    // MARK: - Properties
    let url: URL
    @ObservedObject var viewModel: WebViewModel
    
    // MARK: - UIViewRepresentable
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(viewModel: viewModel)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        
        setupGestures(for: webView, coordinator: context.coordinator)
        setupRefreshControl(for: webView, coordinator: context.coordinator)
        
        context.coordinator.webView = webView
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if viewModel.refreshTrigger != context.coordinator.lastRefreshTrigger {
            context.coordinator.lastRefreshTrigger = viewModel.refreshTrigger
            webView.reload()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupGestures(for webView: WKWebView, coordinator: WebViewCoordinator) {
        let swipeRight = UISwipeGestureRecognizer(target: coordinator, action: #selector(WebViewCoordinator.swipeBack))
        swipeRight.direction = .right
        webView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: coordinator, action: #selector(WebViewCoordinator.swipeForward))
        swipeLeft.direction = .left
        webView.addGestureRecognizer(swipeLeft)
        
        let doubleTap = UITapGestureRecognizer(target: coordinator, action: #selector(WebViewCoordinator.doubleTapRefresh))
        doubleTap.numberOfTapsRequired = 2
        webView.addGestureRecognizer(doubleTap)
    }
    
    private func setupRefreshControl(for webView: WKWebView, coordinator: WebViewCoordinator) {
        let refreshControl = UIRefreshControl()
        refreshControl.customize()
        refreshControl.addTarget(coordinator, action: #selector(WebViewCoordinator.refreshWebView), for: .valueChanged)
        webView.scrollView.addSubview(refreshControl)
        webView.scrollView.bounces = true
        
        coordinator.refreshControl = refreshControl
    }
}
