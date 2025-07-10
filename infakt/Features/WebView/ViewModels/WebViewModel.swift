//
//  WebViewModel.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI
import Combine

class WebViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var state = WebViewState()
    @Published var refreshTrigger = false
    
    // MARK: - Properties
    private let networkMonitoringService: NetworkMonitoringServiceProtocol
    
    // MARK: - Initialization
    init(networkMonitoringService: NetworkMonitoringServiceProtocol = NetworkMonitoringService()) {
        self.networkMonitoringService = networkMonitoringService
        startNetworkMonitoring()
    }
    
    // MARK: - Public Methods
    
    /// Triggers a refresh of the web view
    func refresh() {
        HapticFeedbackManager.mediumImpact()
        refreshTrigger.toggle()
    }
    
    /// Updates loading state and progress
    func updateLoadingState(isLoading: Bool, progress: Double = 0.0) {
        state.isLoading = isLoading
        state.progress = progress
    }
    
    /// Updates navigation state
    func updateNavigationState(canGoBack: Bool, canGoForward: Bool, currentURL: URL?) {
        state.canGoBack = canGoBack
        state.canGoForward = canGoForward
        state.currentURL = currentURL
    }
    
    /// Handles network connectivity changes
    func handleNetworkChange(isConnected: Bool) {
        state.isOffline = !isConnected
        
        // Auto-refresh when connection is restored
        if isConnected && state.isOffline {
            refresh()
        }
    }
    
    // MARK: - Private Methods
    
    private func startNetworkMonitoring() {
        networkMonitoringService.startMonitoring { [weak self] isConnected in
            self?.handleNetworkChange(isConnected: isConnected)
        }
    }
    
    deinit {
        networkMonitoringService.stopMonitoring()
    }
}