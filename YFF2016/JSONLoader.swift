//
//  JSONLoader.swift
//  YFF2016
//
//  Created by Isaac Norman on 16/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import SwiftyJSON

class JSONLoader: NSObject {
    static let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true).first!
    static let documentsDirectoryPath = URL(string: documentsDirectoryPathString)!
    
    class func loadRemoteJSON() {
        loadArtistsJSON()
        loadInstagram()
        
        loadFridayPerformances()
        loadSaturdayPerformances()
        loadSundayPerformances()
        
    }
    
    
    class func fetchArtists() -> [Artist] {
        return generateArtists(data: fetchArtistData())
    }
    
    class func fetchPerformances(day: String) -> [Performance] {
        return generatePerformances(data: fetchPerformanceJSONForDay(day: day))
    }
    
    class func fetchAllPerformances() -> [Performance] {
        var performances: [Performance] = []
        performances.append(contentsOf: fetchPerformances(day: "fri"))
        performances.append(contentsOf: fetchPerformances(day: "sat"))
        performances.append(contentsOf: fetchPerformances(day: "sun"))
        return performances
    }
    
    
    class func loadArtistsJSON() {
        let request = NSMutableURLRequest(url: URL(string: artistsJsonUrl)!)
        
        httpGet(request as URLRequest!){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "artists_remote.json")
            }
        }
    }
    
    class func loadInstagram() {
        let request = NSMutableURLRequest(url: URL(string: instagramUrl)!)
        
        httpGet(request as URLRequest!){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "instagram_remote.json")
            }
        }
        
    }
    
    class func loadFridayPerformances() {
        let request = NSMutableURLRequest(url: URL(string: friPerformancesJsonUrl)!)
        
        httpGet(request as URLRequest!){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "fri_performances_remote.json")
            }
        }
    }
    
    class func loadSaturdayPerformances() {
        let request = NSMutableURLRequest(url: URL(string: satPerformancesJsonUrl)!)
        
        httpGet(request as URLRequest!){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "sat_performances_remote.json")
            }
        }
    }
    
    
    class func loadSundayPerformances() {
        let request = NSMutableURLRequest(url: URL(string: sunPerformancesJsonUrl)!)
        
        httpGet(request as URLRequest!){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "sun_performances_remote.json")
            }
        }
    }
    
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    
    
    class func writeStringToFile(_ data: String, fileName: String) {
        let jsonFilePath = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try data.write(toFile: jsonFilePath, atomically: true, encoding: String.Encoding.utf8)
            do {
                try print(String(contentsOfFile: jsonFilePath, encoding: String.Encoding.utf8))
            } catch {
                
            }
        } catch {
            print("Failed to write file")
        }
    }
    
    class func httpGet(_ request: URLRequest!, callback: @escaping (String, String?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    String.Encoding.ascii.rawValue)!
                callback(result as String, nil)
            }
        })
        task.resume()
    }
    
    class func fetchPerformanceJSONForDay(day: String) -> JSON {
        let fileName = "\(day.lowercased())_performances_remote.json"
        let jsonFilePath = getDocumentsDirectory().appendingPathComponent(fileName)
        let fileManager = FileManager.default
        if (fileManager.fileExists(atPath: jsonFilePath)) {
            return JSON(data: try! Data(contentsOf: URL(fileURLWithPath: jsonFilePath)))
        } else {
            if let jsonFile = Bundle.main.url(forResource: "\(day.lowercased())_performances", withExtension: "json") {
                return JSON(data: try! Data(contentsOf: jsonFile))
            }
        }
       fatalError("Failed to find JSON")
    }

    class func fetchArtistData() -> JSON {
        let fileName = "artists_remote.json"
        let jsonFilePath = getDocumentsDirectory().appendingPathComponent(fileName)
        let fileManager = FileManager.default
        
        if (fileManager.fileExists(atPath: jsonFilePath)) {
            return JSON(data: try! Data(contentsOf: URL(fileURLWithPath: jsonFilePath)))
        } else {
            if let jsonFile = Bundle.main.url(forResource: "artist_json", withExtension: "json") {
                return JSON(data: try! Data(contentsOf: jsonFile))
            }
        }
       fatalError("Failed to find JSON")
    }
    
    class func generateArtists(data: JSON) -> [Artist] {
        var artists: [Artist] = []
        let artistsDictionary = data["artists"]
        
        for artist in artistsDictionary {
            
            artists.append(Artist(json: artist.1))
        }
        
        return artists
    }
    
    class func generatePerformances(data: JSON) -> [Performance] {
        var performances: [Performance] = []
        let performancesDictionary = data["performances"]
        
        for performance in performancesDictionary {
            performances.append(Performance(json: performance.1))
        }
        
        return performances
    }

}
