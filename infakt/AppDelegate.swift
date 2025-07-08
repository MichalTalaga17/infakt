//
//  AppDelegate.swift
//  infakt
//
//  Created by Michał Talaga on 08/07/2025.
//


import UserNotifications
import UIKit


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("🚀 App started - requesting notification permission")
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("📱 Permission granted: \(granted)")
            if let error = error {
                print("❌ Permission error: \(error)")
            }
            
            if granted {
                print("✅ Registering for remote notifications")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("❌ Permission for push notifications denied.")
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("🎯 SUCCESS! Device Token: \(token)")
    }
    
    // DODAJ TĘ FUNKCJĘ - obsługuje błędy rejestracji
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ Failed to register for remote notifications: \(error)")
    }
}
