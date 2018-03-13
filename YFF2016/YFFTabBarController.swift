//
//  YFFTabBarController.swift
//  YFF2016
//
//  Created by Isaac Norman on 24/12/2015.
//  Copyright © 2015 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class YFFTabBarController: UITabBarController {
    
    var incomingSegueIdentifier: String?
    
    var incomingSegueDestinationIndex: [String:Int] = [
        "Program Segue": 0,
        "Map Segue": 1,
        "Artists Segue": 2,
        "Feed Segue": 3
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set tab bar color and text color
        tabBar.barTintColor = UIColor.white
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = YFFGrey
        } else {
            
        }
        // Set the font and size
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont(name: "BebasNeue", size: 10)!], for: UIControlState())

        // Select tab based on which launch button was used to get here
        if let identifier = incomingSegueIdentifier {
            if let destinationIndex = incomingSegueDestinationIndex[identifier] {
                self.selectedIndex = destinationIndex
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
