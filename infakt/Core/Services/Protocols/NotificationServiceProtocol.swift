//
//  NotificationServiceProtocol.swift
//  infakt
//
//  Created by Michał Talaga on 10/07/2025.
//


import Foundation

protocol NotificationServiceProtocol {
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void)
    func scheduleNotification(title: String, body: String)
}