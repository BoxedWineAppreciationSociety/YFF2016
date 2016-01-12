//
//  FirstLaunchViewController.swift
//  YFF2016
//
//  Created by Chris Jewell on 7/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//
import UIKit

class FirstLaunchViewController: UIViewController {

    @IBOutlet weak var programButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var feedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Button Colors
        programButton.tintColor = UIColor.whiteColor()
        mapButton.tintColor = UIColor.whiteColor()
        artistsButton.tintColor = UIColor.whiteColor()
        feedButton.tintColor = UIColor.whiteColor()
        
        programButton.titleLabel?.font = UIFont(name: "SourceSansPro-Semibold", size: 18)
        mapButton.titleLabel?.font = UIFont(name: "SourceSansPro-Semibold", size: 18)
        artistsButton.titleLabel?.font = UIFont(name: "SourceSansPro-Semibold", size: 18)
        feedButton.titleLabel?.font = UIFont(name: "SourceSansPro-Semibold", size: 18)
        
        programButton.backgroundColor = UIColor(red: 199.0/255/0, green: 86.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        mapButton.backgroundColor = UIColor(red: 228.0/255.0, green: 117.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        artistsButton.backgroundColor = UIColor(red: 154.0/255.0, green: 155.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        feedButton.backgroundColor = UIColor(red: 76.0/255.0, green: 133.0/255.0, blue: 121.0/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as! YFFTabBarController
        
        destinationViewController.incomingSegueIdentifier = segue.identifier
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
