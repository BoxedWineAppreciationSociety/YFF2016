//
//  ProgramViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 12/01/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import SwiftyJSON
import UserNotifications
import EasyTipView

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selectedArtist: Artist?
    
    let allFridayPerformances = JSONLoader.fetchPerformances(day: "fri")
    let allSaturdayPerformances = JSONLoader.fetchPerformances(day: "sat")
    let allSundayPerformances = JSONLoader.fetchPerformances(day: "sun")
    
    @IBAction func selectDay(_ sender: programDayButton) {
        if let dayIdentifier = sender.restorationIdentifier {
            clearPerformances()
            clearActiveButton()
            sender.setActive()
            performances = performancesForDay(day: dayIdentifier.lowercased())
            programTableView.reloadData()
            scrollToTop()
        }
    }
    
    @IBOutlet weak var programTableView: UITableView!
    @IBOutlet weak var fridayPerformancesButton: programDayButton!
    @IBOutlet weak var saturdayPerformancesButton: programDayButton!
    @IBOutlet weak var sundayPerformancesButton: programDayButton!
    @IBOutlet weak var selectDayView: UIView!
    
    static let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true).first!
    let documentsDirectoryPath = URL(string: documentsDirectoryPathString)!
    
    var performances = [Performance]()
    let fridayJsonFile = Bundle.main.url(forResource: "friday_performances", withExtension: "json")
    
    // MARK: UIViewController
    @IBOutlet weak var daySelectButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "PROGRAM"
        self.navigationController?.navigationBar.barTintColor = YFFRed
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_alert_selected"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(ProgramViewController.myItineraryAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        programTableView.dataSource = self
        programTableView.delegate = self
        
        performances.append(contentsOf: JSONLoader.fetchPerformances(day: "FRI".lowercased()))
        fridayPerformancesButton.setActive()
        
        selectDayView.addBottomBorderWithColor(color: programTableView.separatorColor!, width: 0.5)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProgramViewController.reload(_:)),name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    @objc func reload(_ notification: NSNotification) {
        programTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        programTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup Tab Bar
        self.tabBarController!.tabBar.tintColor = YFFRed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    func performancesForDay(day: String) -> [Performance] {
        switch day {
            case "fri": return allFridayPerformances
            case "sat": return allSaturdayPerformances
            case "sun": return allSundayPerformances
        default: return allFridayPerformances
        }
        
    }
    
    @objc func myItineraryAction() {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MyItinerary")

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
    
    var tooltipCell: PerformanceCell?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerformanceCell", for: indexPath) as! PerformanceCell
        cell.setup(performanceFor(indexPath))
        cell.tableViewController = self
        cell.performanceTimeLabel.tintColor = YFFOlive
        cell.performanceStageLabel.tintColor = YFFOlive
        cell.artistNameLabel?.font = UIFont(name: "BebasNeueRegular", size: CGFloat(26.0))
        if (indexPath.row == 0 && !isAppAlreadyLaunchedOnce()) {
            cell.showTooltip = true
            self.tooltipCell = cell
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!;
        
        tooltipCell?.dismissTooltip()
        
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
    
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
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
