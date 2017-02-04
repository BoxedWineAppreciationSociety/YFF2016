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
    @IBOutlet weak var termsButton: UIButton!
    
    @IBAction func termsButtonTouchedUpInside(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "http://yackfolkfestival.com/terms-of-use/")!)
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Button Colours
        programButton.backgroundColor = YFFRed
        mapButton.backgroundColor = YFFOrange
        artistsButton.backgroundColor = YFFOlive
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = sender as! UIButton
        
        if button.restorationIdentifier! == "MadeWithLove" {
            super.prepare(for: segue, sender: sender)
            
            if #available(iOS 8.0, *) {
                segue.destination.modalPresentationStyle = .overCurrentContext
            } else {
                segue.destination.modalPresentationStyle = .currentContext
            }
            
            segue.destination.modalTransitionStyle = .crossDissolve

        } else {
            let destinationViewController = segue.destination as! YFFTabBarController
            
            destinationViewController.incomingSegueIdentifier = segue.identifier
        }
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
