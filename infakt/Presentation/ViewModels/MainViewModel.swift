//
//  MainViewModel.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var authenticationViewModel: AuthenticationViewModel
    
    private let webURL = URL(string: "https://konto.infakt.pl")!
    
    // MARK: - Initialization
    init() {
        self.authenticationViewModel = AuthenticationViewModel()
    }
    
    // MARK: - Public Methods
    
    /// Returns the web URL for the application
    func getWebURL() -> URL {
        return webURL
    }
    
    /// Handles app lifecycle changes
    func handleScenePhaseChange(_ scenePhase: ScenePhase) {
        authenticationViewModel.handleAppStateChange(to: scenePhase)
    }
    
    /// Initiates authentication requirement on app launch
    func requireInitialAuthentication() {
        authenticationViewModel.requireAuthentication()
    }
}