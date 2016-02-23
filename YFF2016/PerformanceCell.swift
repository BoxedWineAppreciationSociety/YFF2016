//
//  PerformanceCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 3/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class PerformanceCell: UITableViewCell {
    
    @IBOutlet weak var performanceCellThumb: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var performanceTimeLabel: UILabel!
    @IBOutlet weak var performanceStageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.textLabel?.text = nil
        self.artistNameLabel.text = nil
        self.performanceTimeLabel.text = nil
        self.performanceStageLabel.text = nil
    }
    
    func setup(performance: Performance) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        self.performanceCellThumb.image = UIImage(named: (performance.artist?.imageName)!)
        self.artistNameLabel.text = performance.artist?.name
        self.performanceStageLabel.text = performance.stage
        self.performanceTimeLabel.text = dateFormatter.stringFromDate(performance.time!)
        
        self.performanceStageLabel.textColor = YFFOlive
        self.performanceTimeLabel.textColor = YFFOlive
    }
    
}
