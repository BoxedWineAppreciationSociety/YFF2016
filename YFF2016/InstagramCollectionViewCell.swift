//
//  InstagramCollectionViewCell.swift
//  YFF2016
//
//  Created by Isaac Norman on 11/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class InstagramCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var instagramImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    
    override func prepareForReuse() {
        self.instagramImage.image = nil
    }
    
    func setup(url: String) {
        self.instagramImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
    }
}
