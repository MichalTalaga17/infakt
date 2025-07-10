//
//  AppDelegate.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    private lazy var notificationService: NotificationServiceProtocol = NotificationService()
    
    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        handleSuccessfulRegistration(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        handleFailedRegistration(error: error)
    }
    
    // MARK: - Private Methods
    private func setupNotifications() {
        print("App started - requesting notification permission")
        
        notificationService.requestAuthorization { [weak self] granted, error in
            if let error = error {
                print("Permission error: \(error)")
                return
            }
            
            if granted {
                print("Registering for remote notifications")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Permission for push notifications denied.")
            }
        }
    }
    
    private func handleSuccessfulRegistration(deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("SUCCESS! Device Token: \(token)")
    }
    
    private func handleFailedRegistration(error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
}
