//
//  NetworkMonitoringService.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import Network
import Foundation

class NetworkMonitoringService: NetworkMonitoringServiceProtocol {
    
    // MARK: - Properties
    private let networkMonitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor")
    
    // MARK: - NetworkMonitoringServiceProtocol
    func startMonitoring(statusUpdateHandler: @escaping (Bool) -> Void) {
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                statusUpdateHandler(path.status == .satisfied)
            }
        }
        networkMonitor.start(queue: monitorQueue)
    }
    
    func stopMonitoring() {
        networkMonitor.cancel()
    }
}