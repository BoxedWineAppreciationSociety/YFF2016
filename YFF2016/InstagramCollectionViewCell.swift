//
//  InstagramCollectionViewCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 11/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class InstagramCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var instagramImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.instagramImage.image = nil
    }
    
    func setup(url: String) {
        addBorder()
        
        if let checkedUrl = NSURL(string: url) {
            self.instagramImage.contentMode = .ScaleAspectFill
            downloadImage(checkedUrl)
        }
    }
    
    func addBorder() {
        self.layer.borderColor = UIColor(red: 201.0/255.0, green: 201.0/255.0, blue: 203.0/255.0, alpha: 1.0).CGColor
        self.layer.borderWidth = 1
    }
    
    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.instagramImage.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}
