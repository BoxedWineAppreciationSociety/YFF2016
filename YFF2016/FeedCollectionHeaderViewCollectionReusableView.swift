//
//  FeedCollectionHeaderViewCollectionReusableView.swift
//  YFF2016
//
//  Created by Isaac Norman on 18/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class FeedCollectionHeaderViewCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    
    override func prepareForReuse() {
        self.headerLabel.text = nil
    }
}
