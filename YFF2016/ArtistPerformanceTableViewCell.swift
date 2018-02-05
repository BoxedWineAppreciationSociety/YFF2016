//
//  ArtistPerformanceTableViewCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 24/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ArtistPerformanceTableViewCell: UITableViewCell {
    var tableViewController: UIViewController?
    
    @IBOutlet weak var artistPerformanceTime: UILabel!
    @IBOutlet weak var artistPerformanceDate: UILabel!
    @IBOutlet weak var artistPerformanceStage: UILabel!
    @IBOutlet weak var artistPerformanceRemindMeButton: UIButton!
    
    @IBAction func artistCellRemindMe(_ sender: UIButton) {
        if (UIApplication.shared.scheduledLocalNotifications?.count)! < 1 {
            let message = "You've just added a performance to your alerts. We'll let you know 15 minutes before this artist is playing so you don't miss any of the action!"
            
            let alert = UIAlertController(title: "🎉", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.tableViewController?.present(alert, animated: true, completion: nil)
            
        }
        
        
        NotificationScheduler.toggleNotification(performance: self.cellPerformance!)
        
        toggleNotificationButton()
    }
    
    var cellPerformance: Performance?
    
    func toggleNotificationButton() {
        let existingNotications = UIApplication.shared.scheduledLocalNotifications
        
        var scheduled = false
        
        for existingNotification in existingNotications! {
            let userInfoCurrent = existingNotification.userInfo! as! [String:AnyObject]
            let performanceId = userInfoCurrent["performanceId"]! as! String
            if performanceId == self.cellPerformance?.id {
                scheduled = true
                break;
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            if scheduled {
                self.artistPerformanceRemindMeButton.setImage(UIImage(named: "ic_alert_selected"), for: .normal)
            } else {
                self.artistPerformanceRemindMeButton.setImage(UIImage(named: "ic_alert"), for: .normal)
            }
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ performance: Performance) {
        self.cellPerformance = performance
        toggleNotificationButton()
        
        let timeDateFormatter = DateFormatter()
        timeDateFormatter.dateFormat = "h:mm a"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMMM"
        
        // Content
        self.artistPerformanceDate.text = dateFormatter.string(from: performance.time! as Date)
        self.artistPerformanceTime.text = timeDateFormatter.string(from: performance.time! as Date)
        self.artistPerformanceStage.text = performance.stage
        
        //Colors
        self.artistPerformanceStage.textColor = YFFOlive
        self.artistPerformanceDate.textColor = YFFOlive
    }

}
