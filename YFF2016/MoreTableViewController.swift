//
//  MoreTableViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 19/1/17.
//  Copyright © 2017 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {
    let allLinks = [
        [
            "label": "Festival Info",
            "website": "http://yackfolkfestival.com/festival-info/",
            "image-name": "ic_festival_info"
        ],
        [
            "label": "Buy Tickets",
            "website": "http://yackfolkfestival.com/festival-info/tickets/",
            "image-name": "ic_buy_tickets"
        ],
        [
            "label": "News",
            "website": "http://yackfolkfestival.com/festival-info/news/",
            "image-name": "ic_news"
        ],
        [
            "label": "Our Website",
            "website": "http://yackfolkfestival.com",
            "image-name": "ic_website"
        ],
        [
            "label": "Facebook",
            "website": "https://www.facebook.com/yackfolkfestival/",
            "image-name": "ic_facebook"
        ],
        [
            "label": "Instagram",
            "website": "https://www.instagram.com/yackfolkfestival/",
            "image-name": "ic_instagram"
        ],
        [
            "label": "Twitter",
            "website": "https://twitter.com/yackfolkfest/",
            "image-name": "ic_twitter"
        ]
    ]
    
    var selectedLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Made With Love Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "❤︎", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.heartButtonAction))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        // Change title for NavBar
        // Setup Navigation Controller
        self.navigationItem.title = "MORE"
        self.navigationController?.navigationBar.barTintColor = YFFTeal
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        // Setup Tab Bar
        self.tabBarController!.tabBar.tintColor = YFFTeal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!;
        
        let selectedLink = allLinks[(indexPath as NSIndexPath).item]["website"]
        
        UIApplication.shared.openURL(URL(string: selectedLink!)!)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allLinks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> OverflowCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overflowCell", for: indexPath) as! OverflowCell

        // Configure the cell...
        
        let link = allLinks[(indexPath as NSIndexPath).item]
        
        cell.linkLabel?.font = UIFont(name: "BebasNeueRegular", size: CGFloat(26.0))
        cell.linkLabel?.text = link["label"]
        cell.linkImage.image = UIImage(named: link["image-name"]!)

        return cell
    }
    
    // MARK: Actions
    
    @objc func heartButtonAction() {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MadeWithLove")
        
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        
        self.present(controller, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.

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
