//
//  YFFTabBarController.swift
//  YFF2016
//
//  Created by Isaac Norman on 24/12/2015.
//  Copyright © 2015 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class YFFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set tab bar color and text color
        tabBar.barTintColor = UIColor.whiteColor()
        tabBar.tintColor = UIColor(red: 53.0/255.0, green: 43.0/255.0, blue: 31.0/255.0, alpha: 1.0)
        // Set the font and size
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont(name: "BebasNeue", size: 10)!], forState: .Normal)

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
