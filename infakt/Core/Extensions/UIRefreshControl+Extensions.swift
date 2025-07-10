//
//  UIRefreshControl+Extensions.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//

import UIKit

extension UIRefreshControl {
    
    /// Customizes the refresh control appearance with localized text and styling
    func customize() {
        tintColor = .systemBlue
        attributedTitle = NSAttributedString(
            string: "Refresh page",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.secondaryLabel
            ]
        )
    }
}
