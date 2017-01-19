//
//  ProgramViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 12/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selectedArtist: Artist?

    @IBAction func selectDay(_ sender: programDayButton) {
        if let dayIdentifier = sender.restorationIdentifier {
            clearPerformances()
            clearActiveButton()
            performances = JSONLoader.fetchPerformances(day: dayIdentifier)
            programTableView.reloadData()
            scrollToTop()
            sender.setActive()
        }
    }
    
    @IBOutlet weak var programTableView: UITableView!
    @IBOutlet weak var fridayPerformancesButton: programDayButton!
    @IBOutlet weak var saturdayPerformancesButton: programDayButton!
    @IBOutlet weak var sundayPerformancesButton: programDayButton!
    
    
    static let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true).first!
    let documentsDirectoryPath = URL(string: documentsDirectoryPathString)!
    
    var performances = [Performance]()
    let fridayJsonFile = Bundle.main.url(forResource: "friday_performances", withExtension: "json")
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "PROGRAM"
        self.navigationController?.navigationBar.barTintColor = YFFRed
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "❤︎", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProgramViewController.heartButtonAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        // Setup Tab Bar
        self.tabBarController!.tabBar.tintColor = YFFRed
        
        
        programTableView.dataSource = self
        programTableView.delegate = self
        
        performances.append(contentsOf: JSONLoader.fetchPerformances(day: "FRI".lowercased()))
        fridayPerformancesButton.setActive()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    func heartButtonAction() {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MadeWithLove")
        controller.modalTransitionStyle = .crossDissolve

        if #available(iOS 8.0, *) {
            controller.modalPresentationStyle = .overFullScreen
        } else {
            controller.modalPresentationStyle = .fullScreen
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    
    func generatePerformances(performancesJSON: [JSON]) {
        
        for performance in performancesJSON {
            performances.append(Performance(json: performance))
        }
        performances.sort {
            item1, item2 in
            let time1 = item1.time
            let time2 = item2.time
            return time1!.compare(time2! as Date) == ComparisonResult.orderedAscending
        }
    }
    
    func clearPerformances() {
        performances.removeAll()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerformanceCell", for: indexPath) as! PerformanceCell
        
        cell.setup(performanceFor(indexPath))
        cell.performanceTimeLabel.tintColor = YFFOlive
        cell.performanceStageLabel.tintColor = YFFOlive
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!;
        
        self.selectedArtist = artistFor(indexPath)
        
        performSegue(withIdentifier: "programArtistDetailSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func artistFor(_ indexPath: IndexPath) -> Artist? {
        let performance = performances[(indexPath as NSIndexPath).item]
        return performance.artist
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ArtistDetailViewController {
            viewController.artist = self.selectedArtist
        }
    }

    
    func performanceFor(_ indexPath: IndexPath) -> Performance! {
        return performances[(indexPath as NSIndexPath).item]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return performances.count
    }
    
    fileprivate func scrollToTop() {
        programTableView.setContentOffset(CGPoint.zero, animated:true)
    }
    
    fileprivate func clearActiveButton() {
        self.fridayPerformancesButton.setInactive()
        self.saturdayPerformancesButton.setInactive()
        self.sundayPerformancesButton.setInactive()
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
