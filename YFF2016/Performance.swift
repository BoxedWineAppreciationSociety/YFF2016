//
//  Performance.swift
//  YFF2016
//
//  Created by Isaac Norman on 3/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import Foundation

class Performance {
    var id = ""
    var stage = ""
    var artist: Artist?
    var time: Date?

    
    init(attributes: [String: AnyObject]) {
        self.id = attributes["id"] as! String
        self.stage = attributes["stage"] as! String
        self.artist = Artist(id: attributes["artistId"] as! String)
        self.time = Date(timeIntervalSince1970: (attributes["time"] as? Double)!)
        // TODO time
    }

}
