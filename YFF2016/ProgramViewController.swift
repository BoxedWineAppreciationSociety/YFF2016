//
//  ProgramViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 12/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selectedArtist: Artist?

    @IBAction func selectDay(sender: programDayButton) {
        if let dayIdentifier = sender.titleLabel?.text?.lowercaseString {
            clearPerformances()
            generatePerformances(dictionaryForDay(dayIdentifier)!)
            programTableView.reloadData()
            scrollToTop()
        }
    }
    
    @IBOutlet weak var programTableView: UITableView!
    
    static let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true).first!
    let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
    
    var performances = [Performance]()
    let fridayJsonFile = NSBundle.mainBundle().URLForResource("friday_performances", withExtension: "json")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "PROGRAM"
        self.navigationController?.navigationBar.barTintColor = YFFRed
        
        programTableView.dataSource = self
        programTableView.delegate = self
        
        if let performancesForDay = dictionaryForDay("FRI".lowercaseString) {
            generatePerformances(performancesForDay)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dictionaryForDay(day: String) -> [String:AnyObject]? {
        let fileName = "\(day.lowercaseString)_performances_remote.json"
        let jsonFilePath = getDocumentsDirectory().stringByAppendingPathComponent(fileName)
        let fileManager = NSFileManager.defaultManager()
        var jsonData: NSData?
        
        if (fileManager.fileExistsAtPath(jsonFilePath)) {
            jsonData = NSData(contentsOfFile: jsonFilePath)
        } else {
            if let jsonFile = NSBundle.mainBundle().URLForResource("\(day)_performances", withExtension: "json") {
                jsonData = NSData(contentsOfURL: jsonFile)
            }
        }
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
            if let performancesDictionary = json as? [String: AnyObject] {
                return performancesDictionary
            }
        } catch {
            //
        }
        return nil
    }
    
    func generatePerformances(dictionary: [String: AnyObject]) {
        let performancesDictionary = dictionary["performances"] as! [[String: AnyObject]]
        for performance in performancesDictionary {
            performances.append(Performance(attributes: performance))
        }
        performances.sortInPlace {
            item1, item2 in
            let time1 = item1.time
            let time2 = item2.time
            return time1!.compare(time2!) == NSComparisonResult.OrderedAscending
        }
    }
    
    func clearPerformances() {
        performances.removeAll()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PerformanceCell", forIndexPath: indexPath) as! PerformanceCell
        
        cell.setup(performanceFor(indexPath))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!;
        
        self.selectedArtist = artistFor(indexPath)
        
        performSegueWithIdentifier("programArtistDetailSegue", sender: self)
        
    }
    
    func artistFor(indexPath: NSIndexPath) -> Artist? {
        let performance = performances[indexPath.item]
        return performance.artist
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let viewController = segue.destinationViewController as? ArtistDetailViewController {
            viewController.artist = self.selectedArtist
        }
    }
    
    func performanceFor(indexPath: NSIndexPath) -> Performance! {
        return performances[indexPath.item]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return performances.count
    }
    
    private func scrollToTop() {
        programTableView.setContentOffset(CGPoint.zero, animated:true)
    }
    
    
    private func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
