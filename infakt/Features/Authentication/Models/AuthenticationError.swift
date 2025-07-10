//
//  AuthenticationError.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import Foundation

enum AuthenticationError: Error, LocalizedError {
    case biometricsNotAvailable
    case authenticationFailed
    case userCancel
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .biometricsNotAvailable:
            return "Biometric authentication is not available on this device"
        case .authenticationFailed:
            return "Authentication failed"
        case .userCancel:
            return "User cancelled authentication"
        case .unknown:
            return "Unknown authentication error"
        }
    }
}