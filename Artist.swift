//
//  Artist.swift
//  YFF2016
//
//  Created by Isaac Norman on 20/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class Artist {
    var id = ""
    var name = ""
    var summary = ""
    var imageName: String?
    var facebookURL: String?
    var instagramURL: String?
    var websiteURL: String?
    var youtubeURL: String?
    var iTunesURL: String?
    var soundCloudURL: String?
    var twitterURL: String?
    
    init(attributes: [String: AnyObject]) {
        self.id = attributes["id"] as! String
        self.name = attributes["name"] as! String
        self.summary = attributes["summary"] as! String
        self.imageName = attributes["image_name"] as? String
        
        self.facebookURL = attributes["facebook"] as? String
        self.twitterURL = attributes["twitter"] as? String
        self.instagramURL = attributes["instagram"] as? String
        self.youtubeURL = attributes["youtube"] as? String
        self.iTunesURL = attributes["itunes"] as? String
        self.soundCloudURL = attributes["soundcloud"] as? String
        self.websiteURL = attributes["website"] as? String
    }
    
    init() {
        assert(false)
    }
    
    convenience init(id: String) {
        let jsonData = JSONLoader.fetchArtistData()
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            if let artistsDictionary = json["artists"] as? [[String: String]] {
                let attributes = artistsDictionary.filter({ (dic: [String: String]) -> Bool in
                    return dic["id"] == id
                })
                let foundArtist = attributes[0]

                self.init(attributes: foundArtist)
            } else {
                self.init()
            }
        } catch {
            self.init()
        }
    }
    
    func socialLinks() -> [[String: String?]] {
       return [
            ["websiteLink": self.websiteURL],
            ["facebookLink": self.facebookURL],
            ["twitterLink": self.twitterURL],
            ["youtubeLink": self.youtubeURL],
            ["iTunesLink": self.iTunesURL],
            ["soundCloudLink": self.soundCloudURL],
            ["instagramLink": self.instagramURL]
        ]
    }
}