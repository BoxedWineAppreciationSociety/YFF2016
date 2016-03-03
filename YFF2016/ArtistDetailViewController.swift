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
    @IBOutlet weak var artistAboutButton: ArtistDetailViewButton!
    @IBOutlet weak var artistPlayingTimesButton: ArtistDetailViewButton!
    @IBOutlet weak var artistPerformanceTableView: UITableView!
    @IBOutlet weak var artistDetailScrollView: UIScrollView!
    @IBOutlet weak var artistDescriptionView: UILabel!
    @IBOutlet weak var artistSocialLinksView: UIScrollView!
    @IBOutlet weak var artistLinksLabel: UILabel!
    

    @IBAction func aboutButtonTouchedUp(sender: ArtistDetailViewButton!) {
        sender.setAsActive()
        artistPlayingTimesButton.setAsInactive()
        self.artistDetailScrollView.hidden = false
        self.artistPerformanceTableView.hidden = true
    }
    
    
    @IBAction func playingTimesButtonTouchedUp(sender: ArtistDetailViewButton!) {
        sender.setAsActive()
        artistAboutButton.setAsInactive()
        self.artistDetailScrollView.hidden = true
        self.artistPerformanceTableView.hidden = false
    }
    
    @IBAction func facebookButtonTouchedUp(sender: UIButton) {
        if let url = NSURL(string: (artist?.facebookURL)!) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    var artist: Artist?
    var artistPerformances = [Performance]()
    var validArtistSocialLinks = [[String: String]]()

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
        
        setupSocialButtons()

    }
    
    func setupSocialButtons() {
        if let artistSocialLinks = artist?.socialLinks(){
            for link in artistSocialLinks {
                if (!link.values.first!!.isEmpty){
                    let key = link.keys.first
                    let value = link.values.first
                    validArtistSocialLinks.append([key!: value!!])
                }
            }
        }
        
        if validArtistSocialLinks.count > 0 {
            let buttonViewSpace: CGFloat = 10
            let buttonWidth: CGFloat = 60
            
            for index in 0...(validArtistSocialLinks.count - 1) {
                let x = CGFloat(index) * (buttonWidth + buttonViewSpace)
                let socialLink = validArtistSocialLinks[index]
                
                let button = SocialButton(frame: CGRectMake(x, 0, buttonWidth, buttonWidth))
                button.setup(socialLink.keys.first!)
                button.layer.cornerRadius = buttonWidth / 2
                button.url = socialLink.values.first!
                button.addTarget(self, action: "socialButtonTouchedUpInside:", forControlEvents: .TouchUpInside)
                self.artistSocialLinksView.addSubview(button)
            }
            
            self.artistSocialLinksView.contentSize = CGSizeMake(CGFloat(validArtistSocialLinks.count) * (buttonWidth + buttonViewSpace), buttonWidth)
            
        } else {
            self.artistLinksLabel.hidden = true
            
        }
        
    }
    
    func socialButtonTouchedUpInside(button: SocialButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: button.url!)!)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.artistAboutButton.setAsActive()
        self.artistPlayingTimesButton.setAsInactive()
        self.artistDetailScrollView.hidden = false
        self.artistPerformanceTableView.hidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        self.artistDescriptionView.backgroundColor = UIColor.clearColor()
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
        
        // Slightly complicated way to display the description. 
        // But this gives us the correct line height
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let artistDescription = NSMutableAttributedString(string: (artist?.summary)!)
        artistDescription.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, artistDescription.length))
        
        self.artistDescriptionView.attributedText = artistDescription

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
