//
//  AuthenticationState.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import Foundation

struct AuthenticationState {
    var isAuthenticated: Bool = false
    var isAuthenticating: Bool = false
    var showBlur: Bool = false
    var wasActiveRecently: Bool = false
    var isKeychainLoginInProgress: Bool = false
}
