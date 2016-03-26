//
//  StageFilterCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 26/03/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class StageFilterCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Cell setup
        self.backgroundColor = YFFRed
        // Label Setup
        filterLabel.font = UIFont(name: "BebasNeueRegular", size: 30)
        filterLabel.textColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
