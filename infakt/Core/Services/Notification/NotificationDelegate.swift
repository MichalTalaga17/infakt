//
//  NotificationDelegate.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import UserNotifications
import Foundation

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    // MARK: - Properties
    static let shared = NotificationDelegate()
    
    // MARK: - Initialization
    private override init() {
        super.init()
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, 
                               willPresent notification: UNNotification, 
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}