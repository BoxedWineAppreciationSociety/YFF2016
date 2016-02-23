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
    
    init(attributes: [String: AnyObject]) {
        self.id = attributes["id"] as! String
        self.name = attributes["name"] as! String
        self.summary = attributes["summary"] as! String
        self.imageName = attributes["image_name"] as? String
        self.facebookURL = attributes["facebook"] as? String
    }
    
    init() {
        assert(false)
    }
    
    convenience init(id: String) {
        let jsonFile = NSBundle.mainBundle().URLForResource("artist_json", withExtension: "json")
        let jsonData = NSData(contentsOfURL: jsonFile!)
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
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
}