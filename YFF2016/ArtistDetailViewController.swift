//
//  ArtistDetailViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 20/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistDescriptionView: UITextView!
    @IBOutlet weak var artistAboutButton: ArtistDetailViewButton!
    @IBOutlet weak var artistPlayingTimesButton: ArtistDetailViewButton!
    @IBOutlet weak var artistPerformanceTableView: UITableView!
    

    @IBAction func aboutButtonTouchedUp(sender: ArtistDetailViewButton!) {
        sender.setAsActive()
        artistPlayingTimesButton.setAsInactive()
        self.artistDescriptionView.hidden = false
        self.artistPerformanceTableView.hidden = true
    }
    
    
    @IBAction func playingTimesButtonTouchedUp(sender: ArtistDetailViewButton!) {
        sender.setAsActive()
        artistAboutButton.setAsInactive()
        self.artistDescriptionView.hidden = true
        self.artistPerformanceTableView.hidden = false
    }
    
    var artist: Artist?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistPerformanceTableView.dataSource = self
        artistPerformanceTableView.delegate = self
        
        setupNavBar()
        setupView()
        displayArtist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PerformanceCell", forIndexPath: indexPath)
        
        return cell
    }

    func setupNavBar(){
        // Setup Back Button
        let backButtonImage = UIImage(named: "icon_arrow_back")
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon_arrow_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon_arrow_back")
        self.navigationController
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        // Setup title
        self.navigationItem.title = "ARTIST"
    }
    
    func setupView() {
        self.artistNameLabel.tintColor = UIColor.whiteColor()
        self.artistNameLabel.font = UIFont(name: "BebasNeue", size: 30)
        self.artistNameLabel.layer.shadowRadius = 3.0
        self.artistNameLabel.layer.shadowOffset = CGSizeMake(0, 0)
        self.artistNameLabel.layer.shadowOpacity = 1.0
        
        self.artistDescriptionView.font = UIFont(name: "SourceSansPro-Regular", size: 13)
    }

    func displayArtist() {
        artistImage.contentMode = .ScaleAspectFill

        self.artistNameLabel.text = artist?.name
        self.artistDescriptionView.text = artist?.summary

        if let imageFileName = artist?.imageName {
            if let imageForArtist = UIImage(named: imageFileName) {
                self.artistImage.image = imageForArtist
            }
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
