//
//  infaktApp.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import SwiftUI
import UserNotifications

@main
struct infaktApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        setupNotificationDelegate()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    // MARK: - Private Methods
    private func setupNotificationDelegate() {
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }
}
