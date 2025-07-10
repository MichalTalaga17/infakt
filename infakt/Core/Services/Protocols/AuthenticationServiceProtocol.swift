//
//  AuthenticationServiceProtocol.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import Foundation
import LocalAuthentication

protocol AuthenticationServiceProtocol {
    func authenticate(completion: @escaping (Bool, Error?) -> Void)
    func canEvaluateBiometrics() -> Bool
}