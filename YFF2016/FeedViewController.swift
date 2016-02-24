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
    let refreshControl = UIRefreshControl()
    
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
        
        refreshControl.addTarget(self, action: "startRefresh:", forControlEvents: .ValueChanged)
        
        self.instagramFeedCollectionView.addSubview(refreshControl)
        
    }
    
    func startRefresh(sender: AnyObject?) {
        clearInstagramCells()
        loadInstagram()
        self.instagramFeedCollectionView.reloadData()
        refreshControl.performSelector("endRefreshing", withObject: nil, afterDelay: 0.05)
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let cellWidth = screenWidth * 0.40
        
        return CGSizeMake(cellWidth, cellWidth)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView =
            collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HeaderView", forIndexPath: indexPath) as! FeedCollectionHeaderViewCollectionReusableView
            
            headerView.headerLabel.text = "POST YOUR PHOTOS ON INSTAGRAM WITH #YFF16"
            headerView.headerLabel.font = UIFont(name: "BebasNeueRegular", size: 30)
            return headerView
        default:
            fatalError("Unexpected Element Kind")
        }
    }
    
    
    
    
    func loadInstagram() {
        let fileName = "instagram_remote.json"
        let jsonFilePath = getDocumentsDirectory().stringByAppendingPathComponent(fileName)
        let fileManager = NSFileManager.defaultManager()
        var json: JSON?
        
        if (fileManager.fileExistsAtPath(jsonFilePath)) {
            do {
                json = try JSON(string: String(contentsOfFile: jsonFilePath, encoding: NSUTF8StringEncoding))
            } catch {
                json = JSON(url: url)
            }
        } else {
            json = JSON(url: url)
        }
        
        let imagesJson = json!["data"] as JSON
        for imageJson in imagesJson {
            let image = imageJson.1
            
            let imageUrl = image["images"]["standard_resolution"]["url"].asString
            
            imageUrls.append(imageUrl!)
        }
    }
    
    func clearInstagramCells() {
        imageUrls.removeAll()
    }
    
    private func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
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