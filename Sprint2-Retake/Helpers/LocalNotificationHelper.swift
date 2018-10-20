//
//  LocalNotificationHelper.swift
//  Sprint2-Retake
//
//  Created by Linh Bouniol on 10/20/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    
    var shoppingItemController: ShoppingItemController?
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                NSLog("Error requesting authorization status for local notifications: \(error)")
            }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification(name: String, address: String) {
        let content = UNMutableNotificationContent()
        content.title = "Delivery For \(name)!"
        content.body = "Your shopping item(s) will be delivered to \(address) in 15 minutes."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Schedule request with system
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                NSLog("Error scheduling notification: \(error)")
                return
            }
        }
    }
}
