//
//  MadeWithLoveViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 3/03/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class MadeWithLoveViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var backgroundView: UIView!

    @IBAction func closePopover(_ sender: UIButton) {
        closeModal()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MadeWithLoveViewController.closeModal))
        singleTapRecognizer.numberOfTapsRequired = 1

        backgroundView.addGestureRecognizer(singleTapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func closeModal() {
        self.dismiss(animated: true, completion: nil)
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
