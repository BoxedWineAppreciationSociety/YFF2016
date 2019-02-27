//
//  FeedViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 24/12/2015.
//  Copyright © 2015 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import SwiftyJSON

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
        
        // Setup Tab Bar
        self.tabBarController!.tabBar.tintColor = YFFTeal
        
        
        self.instagramFeedCollectionView.addSubview(refreshControl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramCell", for: indexPath) as! InstagramCollectionViewCell
        
        cell.setup(imageUrls[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth * 0.44
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView =
            collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! FeedCollectionHeaderViewCollectionReusableView
            
            headerView.headerLabel.text = "FOLLOW US ON INSTAGRAM \n @YACKFOLKFESTIVAL"
            headerView.headerLabel.font = UIFont(name: "BebasNeueRegular", size: 26)
            return headerView
        default:
            fatalError("Unexpected Element Kind")
        }
    }
    
    fileprivate func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
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
