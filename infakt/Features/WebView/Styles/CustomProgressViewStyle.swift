//
//  CustomProgressViewStyle.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 3)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0), height: 3)
                    .animation(.linear(duration: 0.3), value: configuration.fractionCompleted)
            }
        }
        .frame(height: 3)
        .scaleEffect(x: 1, y: 2, anchor: .center)
        .animation(.easeInOut(duration: 0.3), value: configuration.fractionCompleted)
    }
}
