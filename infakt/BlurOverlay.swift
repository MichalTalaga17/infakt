//
//  BlurOverlay.swift
//  infakt
//
//  Created by Michał Talaga on 07/07/2025.
//


//
//  BlurOverlay.swift
//  infakt
//
//  Created by Michał Talaga on 07/07/2025.
//

import SwiftUI

struct BlurOverlay: View {
    let onAppear: () -> Void
    
    var body: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .transition(.opacity)
            .onAppear {
                onAppear()
            }
    }
}