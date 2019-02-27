//
//  programDayButton.swift
//  YFF2016
//
//  Created by Isaac Norman on 11/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class programDayButton: UIButton {
    var active: Bool = false
    
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
            attributes: convertToOptionalNSAttributedStringKeyDictionary(NSDictionary(
                object: font!,
                forKey: convertFromNSAttributedStringKey(NSAttributedString.Key.font) as NSCopying) as? [String : AnyObject]))
        
        let font1:UIFont? = UIFont(name: "BebasNeueRegular", size: 16.0)
        let attrString1 = NSMutableAttributedString(
            string: substring2 as String,
            attributes: convertToOptionalNSAttributedStringKeyDictionary(NSDictionary(
                object: font1!,
                forKey: convertFromNSAttributedStringKey(NSAttributedString.Key.font) as NSCopying) as? [String : AnyObject]))
        
        //appending both attributed strings
        attrString.append(attrString1)
        
        //assigning the resultant attributed strings to the button
        self.setAttributedTitle(attrString, for: UIControl.State())
    }
    
    func setActive() {
        if (active) {
            return
        }
        self.active = true
        self.titleLabel?.textColor = YFFRed
    }
    
    func setInactive() {
        if (!active) {
            return
        }
        self.active = false
        self.titleLabel?.textColor = UIColor.black
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
