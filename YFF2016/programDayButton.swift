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
        self.tintColor = UIColor.black
        
        // Font
        self.titleLabel?.font = UIFont(name: "BebasNeueRegular", size: 26)
        self.titleLabel?.textAlignment = .center
        
        // Border
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 201.0/255.0, green: 201.0/255.0, blue: 203.0/255.0, alpha: 1.0).cgColor
        
        //Background
        self.backgroundColor = UIColor.white
        
        // Find the button's label
        let buttonText: NSString = self.titleLabel!.text! as NSString
        
        //getting the range to separate the button title strings
        let newlineRange: NSRange = buttonText.range(of: "\n")
        
        //getting both substrings
        var substring1: NSString = ""
        var substring2: NSString = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = buttonText.substring(to: newlineRange.location) as NSString
            substring2 = buttonText.substring(from: newlineRange.location) as NSString
        }
        
        //assigning diffrent fonts to both substrings
        let font:UIFont? = UIFont(name: "BebasNeueRegular", size: 30)
        let attrString = NSMutableAttributedString(
            string: substring1 as String,
            attributes: NSDictionary(
                object: font!,
                forKey: NSFontAttributeName as NSCopying) as? [String : AnyObject])
        
        let font1:UIFont? = UIFont(name: "BebasNeueRegular", size: 16.0)
        let attrString1 = NSMutableAttributedString(
            string: substring2 as String,
            attributes: NSDictionary(
                object: font1!,
                forKey: NSFontAttributeName as NSCopying) as? [String : AnyObject])
        
        //appending both attributed strings
        attrString.append(attrString1)
        
        //assigning the resultant attributed strings to the button
        self.setAttributedTitle(attrString, for: UIControlState())
    }
    
    func setActive() {
        self.titleLabel?.textColor = YFFRed
    }
    
    func setInactive() {
        self.titleLabel?.textColor = UIColor.black
    }
}
