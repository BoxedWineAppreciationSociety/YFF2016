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
    
    class func loadPerformancesJSON() {
        
        loadFridayPerformances()
        loadSaturdayPerformances()
        loadSundayPerformances()
    }
    
    class func loadFridayPerformances() {
        let request = NSMutableURLRequest(URL: NSURL(string: friPerformancesJsonUrl)!)
        
        httpGet(request){
            (data, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                writeStringToFile(data, fileName: "fri_perfomances_remote.json")
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
                writeStringToFile(data, fileName: "sat_perfomances_remote.json")
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
                writeStringToFile(data, fileName: "sun_perfomances_remote.json")
            }
        }
    }
    
    
    class func writeStringToFile(data: String, fileName: String) {
        let jsonFilePath = documentsDirectoryPath.URLByAppendingPathComponent(fileName)
        let fileManager = NSFileManager.defaultManager()
        
//        if fileManager.fileExistsAtPath("\(jsonFilePath)") {
//            print("Much success")
//        } else {
//            print("fail")
//        }
//        var isDirectory: ObjCBool = false
        
        let created = fileManager.createFileAtPath("\(jsonFilePath)", contents: data.dataUsingEncoding(NSUTF8StringEncoding), attributes: nil)
        if created {
            print("File created ")
            do {
                try print(String(contentsOfFile: "\(jsonFilePath)", encoding: NSUTF8StringEncoding))
            } catch {
                
            }
        } else {
            print("Couldn't create file for some reason")
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
