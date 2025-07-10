//
//  NetworkMonitoringServiceProtocol.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import Foundation

protocol NetworkMonitoringServiceProtocol {
    func startMonitoring(statusUpdateHandler: @escaping (Bool) -> Void)
    func stopMonitoring()
}