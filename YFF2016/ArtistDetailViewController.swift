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
    
    @IBAction func facebookButtonTouchedUp(sender: UIButton) {
        if let url = NSURL(string: (artist?.facebookURL)!) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    var artist: Artist?
    var artistPerformances = [Performance]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistPerformanceTableView.dataSource = self
        artistPerformanceTableView.delegate = self
        
        setupNavBar()
        displayArtist()
        setupView()
        
        loadPerformancesForDay("fri")
        loadPerformancesForDay("sat")
        loadPerformancesForDay("sun")
        sortPerformances()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.artistAboutButton.setAsActive()
        self.artistPlayingTimesButton.setAsInactive()
        self.artistDescriptionView.hidden = false
        self.artistPerformanceTableView.hidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        artistDescriptionView.setContentOffset(CGPoint.zero, animated:false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistPerformances.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PerformanceCell", forIndexPath: indexPath) as! ArtistPerformanceTableViewCell
        
        cell.setup(performanceFor(indexPath))
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }

    func setupNavBar(){
        // Setup Back Button
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
        
        self.artistDescriptionView.font = UIFont(name: "SourceSansPro-Regular", size: 16)
    }
    
    func loadPerformancesForDay(day: String) {
        let jsonData = JSONLoader.fetchPerformanceJSONForDay(day.lowercaseString)
        var allPerformancesDictionary: [[String: AnyObject]] = []
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            if let performancesDictionary = json as? [String: AnyObject] {
                allPerformancesDictionary.appendContentsOf(performancesDictionary["performances"] as! [[String: AnyObject]])
            }
        } catch {
            //
        }
        
        let filteredDictionary = allPerformancesDictionary.filter {
            if let artistId = $0["artistId"] {
                return artistId as! String == artist!.id
            } else {
                return false
            }
        }
        
        for artistPerformance in filteredDictionary {
            artistPerformances.append(Performance(attributes: artistPerformance))
        }
    }
    
    func sortPerformances() {
        artistPerformances.sortInPlace {
            item1, item2 in
            let time1 = item1.time
            let time2 = item2.time
            return time1!.compare(time2!) == NSComparisonResult.OrderedAscending
        }
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
    
    func performanceFor(indexPath: NSIndexPath) -> Performance! {
        return artistPerformances[indexPath.item]
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
