//
//  StageFilterDelegate.swift
//  YFF2016
//
//  Created by Isaac Norman on 28/03/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import Foundation

protocol StageFilterDelegate {
    func StageFilterTableViewControllerDidCancel(controller: StageFilterTableViewController)
    
    // `data` will be the name of the stage we are filtering by
    func StageFilterTableViewControllerDidFinish(controller: StageFilterTableViewController, data: String)
}