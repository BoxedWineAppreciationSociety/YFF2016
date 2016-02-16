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
    
    class func writeStringToFile(data: String, fileName: String) {
        let jsonFilePath = documentsDirectoryPath.URLByAppendingPathComponent(fileName)
        let fileManager = NSFileManager.defaultManager()
        
//        if fileManager.fileExistsAtPath("\(jsonFilePath)") {
//            print("Much success")
//        } else {
//            print("fail")
//        }
//        var isDirectory: ObjCBool = false
        
//        if !fileManager.fileExistsAtPath("\(jsonFilePath)") {
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
//        } else {

//        }
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
