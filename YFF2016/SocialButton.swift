//
//  SocialButton.swift
//  YFF2016
//
//  Created by Isaac Norman on 3/03/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class SocialButton: UIButton {
    var url: String?
    
    func setup(buttonType: String) {

        switch buttonType {
        case "facebookLink":
            self.backgroundColor = facebookBlue
            self.setImage(UIImage(named: "facebookLogo"), forState: .Normal)
        case "twitterLink":
            self.backgroundColor = twitterBlue
            self.setImage(UIImage(named: "twitterLogo"), forState: .Normal)
        case "youtubeLink":
            self.backgroundColor = youtubeRed
            self.setImage(UIImage(named: "youtubeLogo"), forState: .Normal)
        case "instagramLink":
            self.backgroundColor = instagramBlue
            self.setImage(UIImage(named: "feedIconWhite"), forState: .Normal)
        case "iTunesLink":
            self.backgroundColor = iTunesGrey
            self.setImage(UIImage(named: "appleLogo"), forState: .Normal)
        case "soundCloudLink":
            self.backgroundColor = soundCloudOrange
            self.setImage(UIImage(named: "soundcloudLogo"), forState: .Normal)
        default:
            self.backgroundColor = YFFOlive
            self.setImage(UIImage(named: "websiteLinkImage"), forState: .Normal)
            
        }
    }
}