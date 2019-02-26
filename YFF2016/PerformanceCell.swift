//
//  PerformanceCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 3/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import EasyTipView


class PerformanceCell: UITableViewCell {
    
    var performance: Performance?
    var tableViewController: UIViewController?
    var showTooltip: Bool = false
    
    var performanceTip: EasyTipView?
    var tooltipPreferences = EasyTipView.Preferences()
    
    @IBOutlet weak var performanceCellThumb: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var performanceTimeLabel: UILabel!
    @IBOutlet weak var performanceStageLabel: UILabel!
    @IBOutlet weak var remindMeButton: UIButton!
    @IBOutlet weak var performanceDayLabel: UILabel?
    
    @IBAction func remindMe(_ sender: UIButton) {
        if (UIApplication.shared.scheduledLocalNotifications?.count)! < 1 {
            let message = "Added to your lineup! \n\n We’ll alert you 15 minutes before the first pluck of the violin, guitar or heartstring. \n\n"
            
            if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))) {
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge , .sound], categories: nil))
            }

            
            let alert = UIAlertController(title: "🎉", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
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
        super.prepareForReuse()
        
        self.textLabel?.text = nil
        self.artistNameLabel.text = nil
        self.performanceTimeLabel.text = nil
        self.performanceStageLabel.text = nil
        self.performanceCellThumb.image = nil
        self.performanceTip?.dismiss()
        self.performanceTip = nil
        
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
    
    func dismissTooltip() {
        print("Removing tooltip")
        self.performanceTip?.dismiss()
        self.performanceTip = nil
    }
    
    func setup(_ performance: Performance) {
        self.performance = performance
        toggleNotificationButton()
        setupTooltip()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        if let artistImageName = performance.artist?.imageName, !(performance.artist?.imageName?.isEmpty)!, (UIImage(named: artistImageName) != nil) {
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
        
        if (showTooltip) {
            performanceTip = EasyTipView(text: "Get notified 15 minutes before the performance", preferences: tooltipPreferences)
            performanceTip?.show(forView: remindMeButton)
            
//          Make sure we set the default here so that we don't show the tooltip again
            self.showTooltip = false
            UserDefaults.standard.set(true, forKey: "isAppAlreadyLaunchedOnce")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.dismissTooltip()
            }
        }
    }
    
    func setupTooltip() {
        tooltipPreferences.drawing.font = UIFont(name: "Source Sans Pro", size: 16)!
        tooltipPreferences.drawing.foregroundColor = UIColor.white
        tooltipPreferences.drawing.backgroundColor = YFFTeal
        tooltipPreferences.drawing.arrowPosition = .top
        tooltipPreferences.animating.dismissDuration = 1.0
        
        tooltipPreferences.positioning.textHInset = 25
        tooltipPreferences.positioning.textVInset = 20
        tooltipPreferences.positioning.bubbleHInset = 25
        tooltipPreferences.positioning.maxWidth = 300
    }
}
