//
//  ArtistDetailViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 20/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    var artist: Artist?
    
    @IBOutlet weak var artistNameLabel: UILabel!

    @IBOutlet weak var artistDescriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayArtist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayArtist() {
        self.artistNameLabel.text = artist?.name
        self.artistDescriptionView.text = artist?.summary
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
