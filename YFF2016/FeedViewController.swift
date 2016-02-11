//
//  FeedViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 24/12/2015.
//  Copyright © 2015 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var instagramFeedCollectionView: UICollectionView!
    
    let url = "https://api.instagram.com/v1/tags/yff15/media/recent?access_token=3212807.1677ed0.e19c549707764af7a71e8a8445e1534d"
    var imageUrls = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        instagramFeedCollectionView.dataSource = self
        instagramFeedCollectionView.delegate = self
        
        // Change title for NavBar
        // Setup Navigation Controller
        self.navigationItem.title = "FEED"
        self.navigationController?.navigationBar.barTintColor = YFFTeal

        // Do any additional setup after loading the view.
        loadInstagram()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InstagramCell", forIndexPath: indexPath) as! InstagramCollectionViewCell
        
        cell.setup(imageUrls[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    
    func loadInstagram() {
        let json = JSON(url: url)
        let imagesJson = json["data"] as JSON
        for imageJson in imagesJson {
            let image = imageJson.1
            
            let imageUrl = image["images"]["standard_resolution"]["url"].asString
            
            imageUrls.append(imageUrl!)
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