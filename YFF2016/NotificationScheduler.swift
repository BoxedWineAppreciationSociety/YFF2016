//
//  NotificationScheduler.swift
//  YFF2016
//
//  Created by Isaac Norman on 1/2/17.
//  Copyright © 2017 Yackandandah Folk Festival. All rights reserved.
//

import Foundation

class NotificationScheduler {
    class func toggleNotification(performance: Performance) {
        let center = UNUserNotificationCenter.current()
        
        DispatchQueue.global(qos: .userInitiated).sync {
            center.getPendingNotificationRequests { requests in
                var existed = false
                for existingNotification in requests {
                    if existingNotification.identifier == performance.id {
                        existed = true
                        center.removePendingNotificationRequests(withIdentifiers: [existingNotification.identifier])
                        break
                    }
                }
                
                if existed {
                    let feedbackGenerator = UISelectionFeedbackGenerator()
                    feedbackGenerator.prepare()
                    feedbackGenerator.selectionChanged()
                } else {
                    let notification = localNotificationForPerformance(performance: performance)
                    
                    let center = UNUserNotificationCenter.current()
                    center.add(notification, withCompletionHandler: { (error) in
                    })
                    
                    let feedbackGenerator = UISelectionFeedbackGenerator()
                    feedbackGenerator.prepare()
                    feedbackGenerator.selectionChanged()
                    
                }
            }
            
        }
    }
    
    class func localNotificationForPerformance(performance: Performance) -> UNNotificationRequest {
        let scheduledPerformance = performance
        //        let formattedNotificationTime = performance.time!.addingTimeInterval(-15.0 * 60).timeIntervalSince1970
        
        let localNotification = UNMutableNotificationContent.init()
        localNotification.userInfo = ["performanceId": scheduledPerformance.id]
        localNotification.title = "Performance Alert"
        localNotification.body = "\(scheduledPerformance.artist!.name) starts in 15 minutes at \(scheduledPerformance.stage)"
        localNotification.sound = UNNotificationSound.default
        
        
        let date = Date(timeIntervalSinceNow: 300) // NSDate(timeIntervalSince1970: formattedNotificationTime) as Date
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let localNotificationRequest = UNNotificationRequest.init(identifier: scheduledPerformance.id, content: localNotification, trigger: trigger)
        
        return localNotificationRequest
        
    }
}
