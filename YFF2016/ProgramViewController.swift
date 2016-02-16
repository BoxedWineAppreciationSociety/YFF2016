//
//  ProgramViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 12/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func selectDay(sender: programDayButton) {
        if let dayIdentifier = sender.titleLabel?.text?.lowercaseString {
            clearPerformances()
            generatePerformances(dictionaryForDay(dayIdentifier)!)
            programTableView.reloadData()
            scrollToTop()
        }
    }
    
    @IBOutlet weak var programTableView: UITableView!
    
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
//        
//        let jsonData = NSData(contentsOfURL: fridayJsonFile!)
//        
//        do {
//            let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
//            if let performancesDictionary = json as? [String: AnyObject] {
//                generatePerformances(performancesDictionary)
//            }
//        } catch {
//            //
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dictionaryForDay(day: String) -> [String:AnyObject]? {
        if let jsonFile = NSBundle.mainBundle().URLForResource("\(day)_performances", withExtension: "json") {
            
            let jsonData = NSData(contentsOfURL: jsonFile)
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
                if let performancesDictionary = json as? [String: AnyObject] {
                    return performancesDictionary
                }
            } catch {
                //
            }

            
        }
        return nil
    }
            
    func generatePerformances(dictionary: [String: AnyObject]) {
        let performancesDictionary = dictionary["performances"] as! [[String: AnyObject]]
        for performance in performancesDictionary {
            performances.append(Performance(attributes: performance))
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
    
    func performanceFor(indexPath: NSIndexPath) -> Performance! {
        return performances[indexPath.item]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return performances.count
    }
    
    private func scrollToTop() {
        programTableView.setContentOffset(CGPoint.zero, animated:true)
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
