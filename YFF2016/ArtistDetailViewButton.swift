//
//  ArtistDetailViewButton.swift
//  YFF2016
//
//  Created by Isaac Norman on 19/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ArtistDetailViewButton: UIButton {
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Text Color
        self.tintColor = UIColor.blackColor()
        
        // Font
        self.titleLabel?.font = UIFont(name: "BebasNeueRegular", size: 18)
        
        //Background
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    func setAsActive() {
        setUnderline()
        self.tintColor = YFFOlive
    }
    
    func setAsInactive() {
        removeUnderline()
        self.tintColor = UIColor.blackColor()
    }
    
    func setUnderline() {
        let lineView = UIView(frame: CGRectMake(0, self.frame.size.height, self.frame.size.width, 3))
        lineView.backgroundColor = YFFOlive
        lineView.tag = 100
        self.addSubview(lineView)
    }
    
    func removeUnderline() {
       self.viewWithTag(100)?.removeFromSuperview()
    }
    
}