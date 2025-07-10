//
//  MainContentView.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI

struct MainContentView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = MainViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    // MARK: - Body
    var body: some View {
        ZStack {
            WebView(url: viewModel.getWebURL())
                .edgesIgnoringSafeArea(.all)
                .disabled(viewModel.authenticationViewModel.state.showBlur)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if viewModel.authenticationViewModel.state.showBlur {
                BlurOverlay {
                    viewModel.authenticationViewModel.authenticate()
                }
            }
        }
        .clipped()
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.requireInitialAuthentication()
        }
        .onChange(of: scenePhase) { _, newPhase in
            viewModel.handleScenePhaseChange(newPhase)
        }
    }
}
