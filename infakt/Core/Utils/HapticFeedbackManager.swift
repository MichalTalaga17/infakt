//
//  HapticFeedbackManager.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import UIKit

class HapticFeedbackManager {
    
    // MARK: - Public Methods
    
    /// Provides light impact feedback for subtle interactions
    static func lightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    /// Provides medium impact feedback for standard interactions
    static func mediumImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    /// Provides success feedback for completed actions
    static func successFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    /// Provides error feedback for failed actions
    static func errorFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}