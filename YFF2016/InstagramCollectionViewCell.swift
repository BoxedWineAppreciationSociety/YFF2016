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
    
    func setup(_ url: String) {
        addBorder()
        
        if let checkedUrl = URL(string: url) {
            self.instagramImage.contentMode = .scaleAspectFill
            downloadImage(checkedUrl)
        }
    }
    
    func addBorder() {
        self.layer.borderColor = UIColor(red: 201.0/255.0, green: 201.0/255.0, blue: 203.0/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
    }
    
    func downloadImage(_ url: URL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent))
        getDataFromUrl(url) { (data, response, error)  in
            DispatchQueue.main.async { () -> Void in
                guard let data = data , error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.instagramImage.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(_ url:URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: NSError? ) -> Void)) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
            completion(data, response, error as NSError?)
            }) .resume()
    }
}
