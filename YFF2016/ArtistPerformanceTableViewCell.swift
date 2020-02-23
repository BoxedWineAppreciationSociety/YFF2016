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
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if (granted) {
                
                DispatchQueue.global(qos: .userInitiated).sync {
                    NotificationScheduler.toggleNotification(performance: self.cellPerformance!)
                    
                    center.getPendingNotificationRequests { requests in
                        var scheduled = false
                        for existingNotification in requests {
                            if existingNotification.identifier == self.cellPerformance!.id {
                                scheduled = true
                                break
                            }
                        }
                        
                        if (requests.count == 0) {
                            DispatchQueue.main.async {
                                let message = "Added to your lineup! \n\n We’ll alert you 15 minutes before the first pluck of the violin, guitar or heartstring."
                                let alert = UIAlertController(title: "🎉", message: message, preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                
                                self.tableViewController?.present(alert, animated: true, completion: nil)
                            }
                        }
                        
                        DispatchQueue.main.sync {
                            UIView.animate(withDuration: 0.3) {
                                if !scheduled {
                                    self.artistPerformanceRemindMeButton.setImage(UIImage(named: "ic_alert_selected"), for: .normal)
                                } else {
                                    self.artistPerformanceRemindMeButton.setImage(UIImage(named: "ic_alert"), for: .normal)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var cellPerformance: Performance?
    
    func toggleNotificationButton(scheduled: Bool) {
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
        var scheduled = false
        let center = UNUserNotificationCenter.current()
        
        DispatchQueue.global(qos: .userInitiated).async {
            center.getPendingNotificationRequests { requests in
                for existingNotification in requests {
                    if existingNotification.identifier == performance.id {
                        scheduled = true
                        break
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.toggleNotificationButton(scheduled: scheduled)
            }
        }
        
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
