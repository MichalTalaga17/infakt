//
//  AuthenticationService.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import Foundation
import LocalAuthentication


class AuthenticationService: AuthenticationServiceProtocol {
    
    // MARK: - Properties
    private let context = LAContext()
    
    // MARK: - AuthenticationServiceProtocol
    func authenticate(completion: @escaping (Bool, Error?) -> Void) {
        guard canEvaluateBiometrics() else {
            completion(false, AuthenticationError.biometricsNotAvailable) // Don't allow fallback to success
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                             localizedReason: "Unlock the application") { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }
    
    func canEvaluateBiometrics() -> Bool {
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
}
