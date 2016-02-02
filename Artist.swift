//
//  Artist.swift
//  YFF2016
//
//  Created by Isaac Norman on 20/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class Artist {
    var id = "" // No need for :String, if you the value is non-optional, then type inference will kick in
    var name = ""
    var summary = "" // You'll probably end up using CoreData for the DB, which means NSManagedObjects, and description is a reserved word
    
    // Custom init function for one line creation
    // Like Rails, we can provide some default values
    init(id: String, name: String, summary: String = "No summary provided") {
        self.id = id
        self.name = name
        self.summary = summary
    }
    
    init(attributes: [String: AnyObject]) {
        self.id = attributes["id"] as! String
        self.name = attributes["name"] as! String
        self.summary = attributes["summary"] as! String
    }
}