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
        let cancelledNotification = cancelExistingNotificationForPerformance(performance: performance)
        
        if cancelledNotification {
            
        } else {
            let notification = localNotificationForPerformance(performance: performance)
    
            notification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
            UIApplication.shared.scheduleLocalNotification(notification)
            
            if #available(iOS 10.0, *) {
                let feedbackGenerator = UISelectionFeedbackGenerator()
                feedbackGenerator.prepare()
                feedbackGenerator.selectionChanged()
            }

        }
        
        return
    }
    
    class func cancelExistingNotificationForPerformance(performance: Performance) -> Bool {
        var existed = false
        let existingNotifications = UIApplication.shared.scheduledLocalNotifications
        
        for existingNotification in existingNotifications! {
            let userInfoCurrent = existingNotification.userInfo! as! [String:AnyObject]
            let performanceId = userInfoCurrent["performanceId"]! as! String
            if performanceId == performance.id {
                UIApplication.shared.cancelLocalNotification(existingNotification)
                existed = true
                break;
                
            }
        }
        return existed
    }
    
    class func localNotificationForPerformance(performance: Performance) -> UILocalNotification {
        let localNotification = UILocalNotification()
        
        let scheduledPerformance = performance
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        
        let formattedTime = dateFormatter.string(from: performance.time! as Date)
        
        let formattedNotificationTime = performance.time!.addingTimeInterval(-15.0 * 60).timeIntervalSince1970
    
        
        localNotification.userInfo = ["performanceId": scheduledPerformance.id]
        localNotification.fireDate = NSDate(timeIntervalSince1970: formattedNotificationTime) as Date
        if #available(iOS 8.2, *) {
            localNotification.alertTitle = "Performance Alert"
        }
        
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.alertBody = "\(scheduledPerformance.artist!.name) starts in 15 minutes at \(scheduledPerformance.stage)"
        localNotification.timeZone = NSTimeZone.default
        
        return localNotification
        
    }
}
