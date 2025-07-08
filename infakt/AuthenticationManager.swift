//
//  AuthenticationManager.swift
//  infakt
//
//  Created by Michał Talaga on 07/07/2025.
//

import Foundation
import LocalAuthentication
import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isAuthenticating = false
    @Published var showBlur = false
    @Published var wasActiveRecently = false
    
    func authenticate() {
        guard !isAuthenticated && !isAuthenticating else { return }
        
        isAuthenticating = true
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                 localizedReason: "Odblokuj aplikację") { [weak self] success, authError in
                DispatchQueue.main.async {
                    self?.isAuthenticating = false
                    if success {
                        self?.isAuthenticated = true
                        withAnimation {
                            self?.showBlur = false
                        }
                        NotificationManager.shared.requestAuthorization()
                        NotificationManager.shared.scheduleNotification(title: "infakt", body: "Weryfikacja FaceID zakończona sukcesem!")
                    } else {
                        print("❌ Uwierzytelnienie nie powiodło się: \(authError?.localizedDescription ?? "Brak opisu błędu")")
                        NotificationManager.shared.requestAuthorization()
                        NotificationManager.shared.scheduleNotification(title: "infakt", body: "Weryfikacja FaceID zakończona niepowodzeniem!")
                    }
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.isAuthenticating = false
                self?.isAuthenticated = true
                withAnimation {
                    self?.showBlur = false
                }
            }
        }
    }
    
    func handleAppStateChange(to newPhase: ScenePhase) {
        switch newPhase {
        case .active:
            wasActiveRecently = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                if !self.isAuthenticated {
                    self.showBlur = true
                    self.authenticate()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                self?.wasActiveRecently = false
            }
            
        case .background:
            if !wasActiveRecently {
                isAuthenticated = false
                showBlur = true
            }
            
        case .inactive:
            break
            
        @unknown default:
            break
        }
    }
    
    func requireAuthentication() {
        showBlur = true
    }
}
