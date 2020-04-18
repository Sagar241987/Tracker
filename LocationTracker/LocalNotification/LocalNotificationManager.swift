//
//  LocalNotificationManager.swift
//  LocationTracker
//
//  Created by Sagar Gupta on 17/04/20.
//  Copyright © 2020 Sagar Gupta. All rights reserved.
//

import UIKit

class LocalNotificationManager {
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
        }
    }
    
    func scheduleNotifications(location:Location) -> Void {
        
        let content = UNMutableNotificationContent()
        content.title = location.title
        content.body = location.time
        content.sound = .default
        content.subtitle = "Location Cordinate = \(location.lat) , \(location.long)"
        let request = UNNotificationRequest(identifier: location.id, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(location.id)")
        }
            
    }
    
   
    
}
