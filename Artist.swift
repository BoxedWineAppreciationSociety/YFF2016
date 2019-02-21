//
//  Artist.swift
//  YFF2016
//
//  Created by Isaac Norman on 20/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import SwiftyJSON

class Artist {
    var id = ""
    var name = ""
    var summary = ""
    var imageName: String?
    var sortName = ""
    var facebookURL: String?
    var instagramURL: String?
    var websiteURL: String?
    var youtubeURL: String?
    var iTunesURL: String?
    var soundCloudURL: String?
    var twitterURL: String?
    
    init(json: JSON) {
       
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.sortName = json["sort_name"].stringValue
        self.summary = json["summary"].stringValue
        self.imageName = json["image_name"].stringValue
        self.facebookURL = json["facebook"].stringValue
        self.twitterURL = json["twitter"].stringValue
        self.instagramURL = json["instagram"].stringValue
        self.youtubeURL = json["youtube"].stringValue
        self.iTunesURL = json["itunes"].stringValue
        self.soundCloudURL = json["soundcloud"].stringValue
        self.websiteURL = json["website"].stringValue
        
    }
    
    init() {
        assert(false)
    }
    
    class func findById(id: String) -> Artist? {
        let artists = JSONLoader.fetchArtists()
        for artist in artists {
            if artist.id == id {
                return artist
            }
        }
        return nil
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
