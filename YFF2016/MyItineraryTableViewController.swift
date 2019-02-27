//
//  MyItineraryTableViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 4/2/17.
//  Copyright © 2017 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MyItineraryTableViewController: UITableViewController,  DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    var notifications = UIApplication.shared.scheduledLocalNotifications
    var performanceIds: [String] = []
    var performances: [Performance] = []
    var selectedArtist: Artist?
    
    @IBOutlet weak var lineupFooterView: lineupFooterView!
    
    @IBAction func closeModal(_ sender: UIBarButtonItem) {
        self.navigationController!.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
        self.navigationItem.title = "MY LINEUP"
        self.navigationController?.navigationBar.barTintColor = YFFRed
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        notifications = UIApplication.shared.scheduledLocalNotifications
        
        pluckPerformanceIds()
        fetchPerformances()
        sortPerformances()
    }
    
    override func viewWillLayoutSubviews() {
        let notificationType = UIApplication.shared.currentUserNotificationSettings!.types
        if notificationType == [] {
            lineupFooterView.isHidden = false
            lineupFooterView.footerViewTitleLabel.text =  "Not working? \n Head to your Settings to make sure you have Notifications turned on."
            lineupFooterView.footerViewButton.setTitleColor(YFFTeal, for: .normal)
        } else {
            lineupFooterView.isHidden = true
            lineupFooterView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return performances.count
    }
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = lineupFooterView
//        
//        footerView?.backgroundColor = UIColor.green
//        
////        footerView?.frame = CGRect(x: 0, y: 50, width: tableView.frame.width, height: 500)
////        let label = UILabel(frame: footerView.frame)
////        label.text = "Not working? Head to your Settings to make sure you have Notifications turned on."
////        label.font = UIFont(name: "BebasNeueRegular", size: 20.0)
////
////        let button = UIButton(frame: CGRect(x: 30, y: footerView.center.y - 50, width: paddedWidth, height: 100))
////        button.backgroundColor = .white
////        button.setTitleColor(YFFGrey, for: .normal)
////        button.setTitle("Go to Settings", for: .normal)
////        button.titleLabel?.font = UIFont(name: "BebasNeueRegular", size: 20.0)
////        button.titleLabel?.numberOfLines = 0
////        button.titleLabel?.textAlignment = .center
////        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
////
////        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
////
////        footerView.addSubview(label)
////        footerView.addSubview(button)
//        
//        return footerView
//    }

    func sizeFooterToFit() {
        if let footerView = tableView.tableFooterView {
            footerView.setNeedsLayout()
            footerView.layoutIfNeeded()
            
            let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = footerView.frame
            frame.size.height = height
            footerView.frame = frame
            
            tableView.tableFooterView = footerView
        }
    }
    
    
    func pluckPerformanceIds() {
        for notification in notifications! {
            let userInfoCurrent = notification.userInfo! as! [String:AnyObject]
            let performanceId = userInfoCurrent["performanceId"]! as! String
            performanceIds.append(performanceId)
        }
    }
    
    func fetchPerformances() {
        var allPerformances = [Performance]()
        
        allPerformances.append(contentsOf: JSONLoader.fetchPerformances(day: "fri"))
        allPerformances.append(contentsOf: JSONLoader.fetchPerformances(day: "sat"))
        allPerformances.append(contentsOf: JSONLoader.fetchPerformances(day: "sun"))
        
        performances = allPerformances.filter {
            performanceIds.contains($0.id)
        }
        
    }
    
    func sortPerformances() {
        performances.sort {
            item1, item2 in
            let time1 = item1.time
            let time2 = item2.time
            return time1!.compare(time2! as Date) == ComparisonResult.orderedAscending
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PerformanceCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduledPerformanceCell", for: indexPath) as! PerformanceCell
        
        
        cell.setup(performanceFor(indexPath))
        cell.tableViewController = self
        cell.performanceTimeLabel.tintColor = YFFOlive
        cell.performanceStageLabel.tintColor = YFFOlive
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!;
        
        self.selectedArtist = performanceFor(indexPath).artist
        
        performSegue(withIdentifier: "showArtistFromInitinerary", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ArtistDetailViewController {
            viewController.artist = self.selectedArtist
        }
    }

    
    func performanceFor(_ indexPath: IndexPath) -> Performance! {
        return performances[(indexPath as NSIndexPath).item]
    }
    
    // MARK: - Deal with the empty data set
    //Add title for empty dataset
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "You haven’t added any \n performances to your \n lineup yet."
        let attrs = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont(name: "BebasNeueRegular", size: 26)!, convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): YFFGrey]
        return NSAttributedString(string: str.uppercased(), attributes: convertToOptionalNSAttributedStringKeyDictionary(attrs))
    }

    //Add your image
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty_data_notes")
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 50.0
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
