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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ performance: Performance) {
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
