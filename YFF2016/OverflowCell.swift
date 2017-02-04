//
//  OverflowCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 4/2/17.
//  Copyright © 2017 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class OverflowCell: UITableViewCell {

    @IBOutlet weak var linkImage: UIImageView!
    @IBOutlet weak var linkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
