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
        ["Website": "http://yackfolkfestival.com"],
        ["Facebook": "https://www.facebook.com/yackfolkfestival/"],
        ["Instagram": "https://www.instagram.com/yackfolkfestival/"],
        ["Twitter": "https://twitter.com/yackfolkfest/"],
        ["YouTube": "https://www.youtube.com/user/YackandandahFolkFest/"]
        
    ]
    
    var selectedLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let selectedLink = allLinks[(indexPath as NSIndexPath).item].values.first!
        
        UIApplication.shared.openURL(URL(string: selectedLink)!)
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        let linkText = allLinks[(indexPath as NSIndexPath).item]
        
        cell.textLabel?.font = UIFont(name: "BebasNeueBold", size: CGFloat(26.0))
        cell.textLabel?.text = linkText.keys.first

        return cell
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
