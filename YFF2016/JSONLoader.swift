//
//  JSONLoader.swift
//  YFF2016
//
//  Created by Isaac Norman on 16/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class JSONLoader: NSObject {
    static let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true).first!
    static let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
    
    class func loadRemoteJSON() {
        loadArtists()
        
        loadFridayPerformances()
        loadSaturdayPerformances()
        loadSundayPerformances()
        
    }
    
    class func loadArtists() {
        let request = NSMutableURLRequest(URL: NSURL(string: artistsJsonUrl)!)
        
        httpGet(request){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "artists_remote.json")
            }
        }
    }
    
    class func loadFridayPerformances() {
        let request = NSMutableURLRequest(URL: NSURL(string: friPerformancesJsonUrl)!)
        
        httpGet(request){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "fri_performances_remote.json")
            }
        }
    }
    
    class func loadSaturdayPerformances() {
        let request = NSMutableURLRequest(URL: NSURL(string: satPerformancesJsonUrl)!)
        
        httpGet(request){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "sat_performances_remote.json")
            }
        }
    }
    
    
    class func loadSundayPerformances() {
        let request = NSMutableURLRequest(URL: NSURL(string: sunPerformancesJsonUrl)!)
        
        httpGet(request){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "sun_performances_remote.json")
            }
        }
    }
    
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    class func writeStringToFile(data: String, fileName: String) {
        let jsonFilePath = getDocumentsDirectory().stringByAppendingPathComponent(fileName)
        
        do {
            try data.writeToFile(jsonFilePath, atomically: true, encoding: NSUTF8StringEncoding)
            do {
                try print(String(contentsOfFile: jsonFilePath, encoding: NSUTF8StringEncoding))
            } catch {
                
            }
        } catch {
            print("Failed to write file")
        }
    }
    
    class func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    NSASCIIStringEncoding)!
                callback(result as String, nil)
            }
        }
        task.resume()
    }

}
