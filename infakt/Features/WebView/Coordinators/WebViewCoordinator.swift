//
//  WebViewCoordinator.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import WebKit
import Foundation

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    
    // MARK: - Properties
    weak var webView: WKWebView?
    weak var refreshControl: UIRefreshControl?
    
    private let viewModel: WebViewModel
    private var progressObserver: NSKeyValueObservation?
    var lastRefreshTrigger: Bool = false
    
    // MARK: - Initialization
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        viewModel.updateLoadingState(isLoading: true)
        
        setupProgressObserver(for: webView)
        HapticFeedbackManager.lightImpact()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.updateLoadingState(isLoading: false, progress: 1.0)
        viewModel.updateNavigationState(
            canGoBack: webView.canGoBack,
            canGoForward: webView.canGoForward,
            currentURL: webView.url
        )
        
        refreshControl?.endRefreshing()
        checkAuthenticationStatus(in: webView)
        HapticFeedbackManager.successFeedback()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        viewModel.updateLoadingState(isLoading: false)
        refreshControl?.endRefreshing()
        HapticFeedbackManager.errorFeedback()
    }
    
    // MARK: - Gesture Actions
    @objc func swipeBack() {
        guard let webView = webView, webView.canGoBack else { return }
        HapticFeedbackManager.mediumImpact()
        webView.goBack()
    }
    
    @objc func swipeForward() {
        guard let webView = webView, webView.canGoForward else { return }
        HapticFeedbackManager.mediumImpact()
        webView.goForward()
    }
    
    @objc func doubleTapRefresh() {
        guard let webView = webView else { return }
        HapticFeedbackManager.mediumImpact()
        webView.reload()
    }
    
    @objc func refreshWebView() {
        guard let webView = webView, let refreshControl = refreshControl else { return }
        HapticFeedbackManager.mediumImpact()
        webView.reload()
        
        // Ensure refresh control ends after minimum duration
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupProgressObserver(for webView: WKWebView) {
        progressObserver = webView.observe(\.estimatedProgress, options: .new) { [weak self] _, _ in
            DispatchQueue.main.async {
                self?.viewModel.updateLoadingState(isLoading: true, progress: webView.estimatedProgress)
            }
        }
    }
    
    private func checkAuthenticationStatus(in webView: WKWebView) {
        // Check authentication status after page load
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
                    print("SessionStorage error: \(error.localizedDescription)")
                    return
                }
                
                if let clientId = result as? String, !clientId.isEmpty {
                    print("User logged in, clientId: \(clientId)")
                } else {
                    print("User not logged in (no .clientId in sessionStorage)")
                }
            }
        }
    }
    
    deinit {
        progressObserver?.invalidate()
    }
}
