//
//  LaunchViewButton.swift
//  YFF2016
//
//  Created by Isaac Norman on 12/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class LaunchViewButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Text Color
        self.tintColor = UIColor.whiteColor()
        
        // Font
        self.titleLabel?.font = UIFont(name: "SourceSansPro-Semibold", size: 18)
        
        // Corner Radius
        self.layer.cornerRadius = 6

    }
}