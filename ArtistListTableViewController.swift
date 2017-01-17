//
//  ArtistListTableViewController.swift
//  YFF2016
//
//  Created by Chris Jewell on 19/12/2015.
//  Copyright © 2015 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArtistListTableViewController: UITableViewController {
    static let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true).first!
    let documentsDirectoryPath = URL(string: documentsDirectoryPathString)!

    
    var artistSectionTitles:Array<NSString> = []
    var selectedArtist: Artist?
    
    let jsonFile = Bundle.main.url(forResource: "artist_json", withExtension: "json")
    
    var artists = [Artist]()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set status bar for update
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artists.append(contentsOf: JSONLoader.fetchArtists())
        sortArtists()
    

        // Setup Navigation Controller
        self.navigationItem.title = "ARTISTS"
        self.navigationController?.navigationBar.barTintColor = YFFOlive
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func sortArtists() {
        artists.sort {
            artist1, artist2 in
            let name1 = artist1.name
            let name2 = artist2.name
            return name1 < name2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artists.count
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return (artistSectionTitles[section] as String).capitalizedString
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        // Style the cell
        
        // Setup the artist
        let artist = artistFor(indexPath)
        cell.textLabel?.text = artist?.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!;
        
        self.selectedArtist = artistFor(indexPath)
        
        performSegue(withIdentifier: "artistDetailSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ArtistDetailViewController {
            viewController.artist = self.selectedArtist
        }
    }
    
    func artistFor(_ indexPath: IndexPath) -> Artist? {
        return artists[(indexPath as NSIndexPath).item]
    }
    
    fileprivate func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
