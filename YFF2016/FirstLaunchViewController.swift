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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Button Colours
        programButton.backgroundColor = YFFRed
        mapButton.backgroundColor = YFFOrange
        artistsButton.backgroundColor = YFFOlive
        feedButton.backgroundColor = YFFTeal
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
