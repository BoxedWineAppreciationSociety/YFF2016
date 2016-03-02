//
//  ArtistPerformanceTableViewCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 24/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ArtistPerformanceTableViewCell: UITableViewCell {
    @IBOutlet weak var artistPerformanceTime: UILabel!
    @IBOutlet weak var artistPerformanceDate: UILabel!
    @IBOutlet weak var artistPerformanceStage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(performance: Performance) {
        let timeDateFormatter = NSDateFormatter()
        timeDateFormatter.dateFormat = "h:mm a"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMMM"
        
        // Content
        self.artistPerformanceDate.text = dateFormatter.stringFromDate(performance.time!)
        self.artistPerformanceTime.text = timeDateFormatter.stringFromDate(performance.time!)
        self.artistPerformanceStage.text = performance.stage
        
        //Colors
        self.artistPerformanceStage.textColor = YFFOlive
        self.artistPerformanceDate.textColor = YFFOlive
    }

}
