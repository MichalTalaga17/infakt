//
//  WebViewState.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import Foundation

struct WebViewState {
    var isLoading: Bool = false
    var canGoBack: Bool = false
    var canGoForward: Bool = false
    var isOffline: Bool = false
    var progress: Double = 0.0
    var currentURL: URL?
}