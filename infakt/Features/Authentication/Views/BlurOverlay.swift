//
//  BlurOverlay.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI

struct BlurOverlay: View {
    
    // MARK: - Properties
    let onAppear: () -> Void
    
    // MARK: - Body
    var body: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .transition(.opacity)
            .onAppear {
                onAppear()
            }
    }
}