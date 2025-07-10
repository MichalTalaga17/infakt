//
//  AuthenticationViewModel.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//

import SwiftUI
import Combine

class AuthenticationViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var state = AuthenticationState()
    
    // MARK: - Properties
    private let authenticationService: AuthenticationServiceProtocol
    private let notificationService: NotificationServiceProtocol
    
    // MARK: - Initialization
    init(authenticationService: AuthenticationServiceProtocol = AuthenticationService(),
         notificationService: NotificationServiceProtocol = NotificationService()) {
        self.authenticationService = authenticationService
        self.notificationService = notificationService
        print("🔑 AuthenticationViewModel initialized")
    }
    
    // MARK: - Public Methods
    
    /// Initiates authentication process if not already authenticated or authenticating
    func authenticate(usingKeychain: Bool = false) {
        print("🔑 authenticate() called - usingKeychain: \(usingKeychain)")
        print("🔑 Current state - isAuthenticated: \(state.isAuthenticated), isAuthenticating: \(state.isAuthenticating)")
        
        guard !state.isAuthenticated && !state.isAuthenticating else {
            print("🔑 Authentication skipped - already authenticated or in progress")
            return
        }
        
        print("🔑 Starting authentication process...")
        state.isAuthenticating = true
        
        if usingKeychain {
            print("🔑 Setting keychain login in progress...")
            state.isKeychainLoginInProgress = true
        }
        
        authenticationService.authenticate { [weak self] success, error in
            print("🔑 Authentication service callback - success: \(success), error: \(error?.localizedDescription ?? "none")")
            DispatchQueue.main.async {
                self?.handleAuthenticationResult(success: success, error: error)
            }
        }
    }
    
    /// Handles app state changes and manages authentication flow
    func handleAppStateChange(to newPhase: ScenePhase) {
        print("🔄 Scene phase changed to: \(newPhase)")
        switch newPhase {
        case .active:
            print("🔄 Handling active state...")
            handleActiveState()
        case .background:
            print("🔄 Handling background state...")
            handleBackgroundState()
        case .inactive:
            print("🔄 Scene inactive - no action")
            break
        @unknown default:
            print("🔄 Unknown scene phase")
            break
        }
    }
    
    /// Forces authentication requirement by showing blur overlay
    func requireAuthentication() {
        print("🔑 requireAuthentication() called")
        state.showBlur = true
    }
    
    // MARK: - Private Methods
    
    private func handleAuthenticationResult(success: Bool, error: Error?) {
        print("🔑 handleAuthenticationResult - success: \(success), error: \(error?.localizedDescription ?? "none")")
        
        state.isAuthenticating = false
        state.isKeychainLoginInProgress = false
        
        if success {
            print("🔑 Authentication successful - updating UI")
            state.isAuthenticated = true
            withAnimation {
                state.showBlur = false
            }
            scheduleSuccessNotification()
        } else {
            print("🔑 Authentication failed")
            scheduleFailureNotification()
            print("Authentication failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        
        print("🔑 Final state - isAuthenticated: \(state.isAuthenticated), showBlur: \(state.showBlur)")
    }
    
    private func handleActiveState() {
        print("🔄 handleActiveState() called")
        print("🔄 Current state - isAuthenticated: \(state.isAuthenticated), isAuthenticating: \(state.isAuthenticating), showBlur: \(state.showBlur)")
        
        state.wasActiveRecently = true
        
        // Jeśli nie jest uwierzytelniony, wymagaj Face ID
        if !state.isAuthenticated && !state.isAuthenticating {
            print("🔄 Authentication needed - scheduling authentication...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else {
                    print("🔄 Self is nil in delayed authentication")
                    return
                }
                
                print("🔄 Delayed authentication check - isAuthenticated: \(self.state.isAuthenticated), isAuthenticating: \(self.state.isAuthenticating)")
                
                // Double check the state hasn't changed
                if !self.state.isAuthenticated && !self.state.isAuthenticating {
                    print("🔄 Showing blur and starting authentication...")
                    self.state.showBlur = true
                    self.authenticate(usingKeychain: true)
                } else {
                    print("🔄 State changed - skipping authentication")
                }
            }
        } else {
            print("🔄 No authentication needed - already authenticated or in progress")
        }
        
        // Reset recent activity flag after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            print("🔄 Resetting wasActiveRecently flag")
            self?.state.wasActiveRecently = false
        }
    }
    
    private func handleBackgroundState() {
        print("🔄 handleBackgroundState() called")
        print("🔄 Current state - isAuthenticated: \(state.isAuthenticated), isAuthenticating: \(state.isAuthenticating)")
        
        // Resetuj stan uwierzytelnienia gdy aplikacja idzie w tło
        // But don't reset if authentication is in progress
        if !state.isAuthenticating {
            print("🔄 Resetting authentication state")
            state.isAuthenticated = false
        } else {
            print("🔄 Authentication in progress - not resetting state")
        }
    }
    
    private func scheduleSuccessNotification() {
        print("🔔 Scheduling success notification")
        notificationService.scheduleNotification(
            title: "infakt",
            body: "FaceID verification completed successfully!"
        )
    }
    
    private func scheduleFailureNotification() {
        print("🔔 Scheduling failure notification")
        notificationService.scheduleNotification(
            title: "infakt",
            body: "FaceID verification failed!"
        )
    }
}
