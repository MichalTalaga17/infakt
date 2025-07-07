//
//  MainContentView.swift
//  infakt
//
//  Created by Michał Talaga on 07/07/2025.
//

import SwiftUI

struct MainContentView: View {
    @StateObject private var authManager = AuthenticationManager()
    @Environment(\.scenePhase) private var scenePhase
    
    private let webURL = URL(string: "https://konto.infakt.pl")!
    
    var body: some View {
        ZStack {
            WebView(url: webURL)
                .edgesIgnoringSafeArea(.all)
                .disabled(authManager.showBlur)
            
            if authManager.showBlur {
                BlurOverlay {
                    authManager.authenticate()
                }
            }
        }
        .clipped()
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            authManager.requireAuthentication()
        }
        .onChange(of: scenePhase) { _, newPhase in
            authManager.handleAppStateChange(to: newPhase)
        }
    }
}
