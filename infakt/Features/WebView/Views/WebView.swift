//
//  WebView.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI

struct WebView: View {
    
    // MARK: - Properties
    let url: URL
    @StateObject private var viewModel = WebViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            WebViewRepresentable(
                url: url,
                viewModel: viewModel
            )
            .border(Color.red.opacity(0.2), width: 1)
            
            // Progress Bar - POPRAWKA: dodane sprawdzenie progress > 0
            VStack {
                if viewModel.state.isLoading && viewModel.state.progress > 0 && viewModel.state.progress < 1.0 {
                    ProgressView(value: viewModel.state.progress)
                        .progressViewStyle(CustomProgressViewStyle())
                        .transition(.opacity)
                }
                Spacer()
            }
            
            // Loading View
            if viewModel.state.isLoading && viewModel.state.progress < 0.1 {
                LoadingView()
                    .transition(.opacity.combined(with: .scale))
            }
            
            // Offline View
            if viewModel.state.isOffline {
                OfflineView(onRetry: viewModel.refresh)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.state.isLoading)
        .animation(.easeInOut(duration: 0.3), value: viewModel.state.isOffline)
    }
}
