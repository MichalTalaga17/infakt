//
//  OfflineView.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI

struct OfflineView: View {
    
    // MARK: - Properties
    let onRetry: () -> Void
    
    // MARK: - State
    @State private var isAnimating = false
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 40))
                .foregroundColor(.red)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
            
            VStack(spacing: 8) {
                Text("No Connection")
                    .font(.system(size: 18, weight: .semibold))
                
                Text("Check your internet connection")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: onRetry) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Try Again")
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(30)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .onAppear {
            isAnimating = true
        }
    }
}
