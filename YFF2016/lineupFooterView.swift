//
//  lineupFooterView.swift
//  YFF2016
//
//  Created by Isaac Norman on 26/2/19.
//  Copyright © 2019 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class lineupFooterView: UIView {


    @IBOutlet weak var footerViewTitleLabel: UILabel!
    @IBOutlet weak var footerViewButton: UIButton!
    @IBAction func footerViewButtonTouchedUpInside(_ sender: Any) {
        let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
