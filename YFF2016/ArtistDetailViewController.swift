//
//  ArtistDetailViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 20/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    let artists = [
        Artist(id: "1", name: "The Kite String Tangle"),
        Artist(id: "2", name: "Meg Mac", summary: "Melbourne artist"),
        Artist(id: "3", name: "Chris Isaak", summary: "Coffee house favourite")
    ]
    
    var artistId: String?
    
    @IBOutlet weak var artistNameLabel: UILabel!

    @IBOutlet weak var artistDescriptionView: UITextView!

    var artist: Artist?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find the artist to display.
        if let id = artistId {
            self.artist = findArtist(id)
        }
        
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
    
    func findArtist(id: String) -> Artist? {
        return artists.filter{ $0.id == id }.first
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
