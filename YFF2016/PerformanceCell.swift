//
//  PerformanceCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 3/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class PerformanceCell: UITableViewCell {
    
    var performance: Performance?
    var tableViewController: UIViewController?
    
    @IBOutlet weak var performanceCellThumb: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var performanceTimeLabel: UILabel!
    @IBOutlet weak var performanceStageLabel: UILabel!
    @IBOutlet weak var remindMeButton: UIButton!
    @IBOutlet weak var performanceDayLabel: UILabel?
    
    @IBAction func remindMe(_ sender: UIButton) {
        if (UIApplication.shared.scheduledLocalNotifications?.count)! < 1 {
            let message = "You've just added a performance to your alerts. We'll let you know 15 minutes before this artist is playing so you don't miss any of the action!"
            
            let alert = UIAlertController(title: "🎉", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.tableViewController?.present(alert, animated: true, completion: nil)
            
        }
        
        
        NotificationScheduler.toggleNotification(performance: self.performance!)
        
        toggleNotificationButton()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.textLabel?.text = nil
        self.artistNameLabel.text = nil
        self.performanceTimeLabel.text = nil
        self.performanceStageLabel.text = nil
        self.performanceCellThumb.image = nil
    }
    
    func toggleNotificationButton() {
        let existingNotications = UIApplication.shared.scheduledLocalNotifications
        
        var scheduled = false
        
        for existingNotification in existingNotications! {
            let userInfoCurrent = existingNotification.userInfo! as! [String:AnyObject]
            let performanceId = userInfoCurrent["performanceId"]! as! String
            if performanceId == self.performance?.id {
                scheduled = true
                break;
            }
        }
        
        UIView.animate(withDuration: 0.3) { 
            if scheduled {
                self.remindMeButton.setImage(UIImage(named: "ic_alert_selected"), for: .normal)
            } else {
                self.remindMeButton.setImage(UIImage(named: "ic_alert"), for: .normal)
            }
        }
        
    }
    
    func setup(_ performance: Performance) {
        self.performance = performance
        toggleNotificationButton()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        if let  artistImageName = performance.artist?.imageName, !(performance.artist?.imageName?.isEmpty)! {
            let artistImage = UIImage(named: artistImageName)
            self.performanceCellThumb.image = artistImage
        } else {
            self.performanceCellThumb.image = UIImage(named: "artistPlaceholder")
        }
        
        self.artistNameLabel.text = performance.artist?.name
        self.performanceStageLabel.text = performance.stage
        self.performanceTimeLabel.text = dateFormatter.string(from: performance.time! as Date)
        
        self.performanceStageLabel.textColor = YFFOlive
        self.performanceTimeLabel.textColor = YFFOlive
        
        let dayDateFormatter = DateFormatter()
        dayDateFormatter.dateFormat = "EEEE dd MMMM"
        
        self.performanceDayLabel?.textColor = YFFOlive
        self.performanceDayLabel?.text = dayDateFormatter.string(from: performance.time! as Date)
    }
    
}
