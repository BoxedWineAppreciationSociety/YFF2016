//
//  ArtistListTableViewController.swift
//  YFF2016
//
//  Created by Chris Jewell on 19/12/2015.
//  Copyright © 2015 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ArtistListTableViewController: UITableViewController {
    static let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true).first!
    let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!

    
    var artistSectionTitles:Array<NSString> = []
    var selectedArtist: Artist?
    
    let jsonFile = NSBundle.mainBundle().URLForResource("artist_json", withExtension: "json")
    
    var artists = [Artist]()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        // Set status bar for update
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonData = JSONLoader.fetchArtistData()
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
            if let artistsDictionary = json as? [String: AnyObject] {
                generateArtists(artistsDictionary)
            }
        } catch {
            //
        }

        // Setup Navigation Controller
        self.navigationItem.title = "ARTISTS"
        self.navigationController?.navigationBar.barTintColor = YFFOlive
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func generateArtists(dictionary: [String: AnyObject]) {
        let artistsDictionary = dictionary["artists"] as! [[String: AnyObject]]
        
        for artist in artistsDictionary {
            artists.append(Artist(attributes: artist))
        }
        
        artists.sortInPlace {
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
//
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artists.count
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return (artistSectionTitles[section] as String).capitalizedString
//    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath)
        
        // Style the cell
        
        // Setup the artist
        let artist = artistFor(indexPath)
        cell.textLabel?.text = artist?.name

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!;
        
        self.selectedArtist = artistFor(indexPath)
        
        performSegueWithIdentifier("artistDetailSegue", sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? ArtistDetailViewController {
            viewController.artist = self.selectedArtist
        }
    }
    
    func artistFor(indexPath: NSIndexPath) -> Artist? {
        return artists[indexPath.item]
    }
    
    private func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
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
