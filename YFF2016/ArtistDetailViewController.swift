//
//  ArtistDetailViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 20/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import SwiftyJSON

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
    

    @IBAction func aboutButtonTouchedUp(_ sender: ArtistDetailViewButton!) {
        sender.setAsActive()
        artistPlayingTimesButton.setAsInactive()
        self.artistDetailScrollView.isHidden = false
        self.artistPerformanceTableView.isHidden = true
    }
    
    
    @IBAction func playingTimesButtonTouchedUp(_ sender: ArtistDetailViewButton!) {
        sender.setAsActive()
        artistAboutButton.setAsInactive()
        self.artistDetailScrollView.isHidden = true
        self.artistPerformanceTableView.isHidden = false
    }
    
    @IBAction func facebookButtonTouchedUp(_ sender: UIButton) {
        if let url = URL(string: (artist?.facebookURL)!) {
            UIApplication.shared.openURL(url)
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
        
        DispatchQueue.main.async {
            self.generatePerformancesForArtist()
            self.artistPerformanceTableView.reloadData()
        }
        
        sortPerformances()
        setupSocialButtons()
    }
    
    func generatePerformancesForArtist() {
        var allPerformances = [Performance]()
        
        allPerformances.append(contentsOf: JSONLoader.fetchPerformances(day: "fri"))
        allPerformances.append(contentsOf: JSONLoader.fetchPerformances(day: "sat"))
        allPerformances.append(contentsOf: JSONLoader.fetchPerformances(day: "sun"))
        
        artistPerformances = allPerformances.filter {
            $0.artist?.id == artist?.id
        }
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
            let buttonWidth: CGFloat = 55
            
            for index in 0...(validArtistSocialLinks.count - 1) {
                let x = CGFloat(index) * (buttonWidth + buttonViewSpace) + 20
                let socialLink = validArtistSocialLinks[index]
                
                let button = SocialButton(frame: CGRect(x: x, y: 0, width: buttonWidth, height: buttonWidth))
                button.setup(socialLink.keys.first!)
                button.layer.cornerRadius = buttonWidth / 2
                button.url = socialLink.values.first!
                button.addTarget(self, action: #selector(ArtistDetailViewController.socialButtonTouchedUpInside(_:)), for: .touchUpInside)
                self.artistSocialLinksView.addSubview(button)
            }
            
            self.artistSocialLinksView.contentSize = CGSize(width: CGFloat(validArtistSocialLinks.count) * (buttonWidth + buttonViewSpace) + 20, height: buttonWidth)
            
        } else {
            self.artistLinksLabel.isHidden = true
            
        }
        
    }
    
    func socialButtonTouchedUpInside(_ button: SocialButton) {
        UIApplication.shared.openURL(URL(string: button.url!)!)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.artistAboutButton.setAsActive()
        self.artistPlayingTimesButton.setAsInactive()
        self.artistDetailScrollView.isHidden = false
        self.artistPerformanceTableView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistPerformances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerformanceCell", for: indexPath) as! ArtistPerformanceTableViewCell
        
        cell.setup(performanceFor(indexPath))
        
        cell.backgroundColor = UIColor.clear
        return cell
    }

    func setupNavBar(){
        // Setup Back Button
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icon_arrow_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icon_arrow_back")
        self.navigationController?.navigationBar.tintColor = UIColor.white

        // Setup title
        self.navigationItem.title = "ARTIST"
    }
    
    func setupView() {
        self.artistNameLabel.tintColor = UIColor.white
        self.artistNameLabel.font = UIFont(name: "BebasNeue", size: 30)
        self.artistNameLabel.layer.shadowRadius = 3.0
        self.artistNameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.artistNameLabel.layer.shadowOpacity = 1.0
        
        self.artistDescriptionView.font = UIFont(name: "SourceSansPro-Regular", size: 16)
        self.artistDescriptionView.backgroundColor = UIColor.clear
    }
        
    func sortPerformances() {
        artistPerformances.sort {
            item1, item2 in
            let time1 = item1.time
            let time2 = item2.time
            return time1!.compare(time2! as Date) == ComparisonResult.orderedAscending
        }
    }

    func displayArtist() {
        artistImage.contentMode = .scaleAspectFill

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
    
    func performanceFor(_ indexPath: IndexPath) -> Performance! {
        return artistPerformances[(indexPath as NSIndexPath).item]
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
