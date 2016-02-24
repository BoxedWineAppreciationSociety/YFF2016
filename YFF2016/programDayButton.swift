//
//  programDayButton.swift
//  YFF2016
//
//  Created by Isaac Norman on 11/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class programDayButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Text Color
        self.tintColor = UIColor.blackColor()
        
        // Font
        self.titleLabel?.font = UIFont(name: "BebasNeueRegular", size: 26)
        
        // Border
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 201.0/255.0, green: 201.0/255.0, blue: 203.0/255.0, alpha: 1.0).CGColor
        
        //Background
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func setActive() {
        self.tintColor = YFFRed
    }
    
    func setInactive() {
        self.tintColor = UIColor.blackColor()
    }
}
