//
//  Performance.swift
//  YFF2016
//
//  Created by Isaac Norman on 3/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import Foundation
import SwiftyJSON

class Performance {
    var id = ""
    var stage = ""
    var artist: Artist?
    var time: Date?

    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.stage = json["stage"].stringValue
        self.artist = Artist.findById(id: json["artistId"].stringValue)
        self.time = Date(timeIntervalSince1970: (json["time"].doubleValue))
    }
    
    class func findById(id: String) -> Performance? {
        let performances = JSONLoader.fetchAllPerformances()
        for performance in performances {
            if performance.id == id {
                return performance
            }
        }
        return nil
    }

}
