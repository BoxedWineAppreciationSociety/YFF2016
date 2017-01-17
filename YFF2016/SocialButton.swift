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
    
    func setup(_ buttonType: String) {

        switch buttonType {
        case "facebookLink":
            self.backgroundColor = facebookBlue
            self.setImage(UIImage(named: "facebookLogo"), for: UIControlState())
        case "twitterLink":
            self.backgroundColor = twitterBlue
            self.setImage(UIImage(named: "twitterLogo"), for: UIControlState())
        case "youtubeLink":
            self.backgroundColor = youtubeRed
            self.setImage(UIImage(named: "youtubeLogo"), for: UIControlState())
        case "instagramLink":
            self.backgroundColor = instagramBlue
            self.setImage(UIImage(named: "feedIconWhite"), for: UIControlState())
        case "iTunesLink":
            self.backgroundColor = iTunesGrey
            self.setImage(UIImage(named: "appleLogo"), for: UIControlState())
        case "soundCloudLink":
            self.backgroundColor = soundCloudOrange
            self.setImage(UIImage(named: "soundcloudLogo"), for: UIControlState())
        default:
            self.backgroundColor = YFFOlive
            self.setImage(UIImage(named: "websiteLinkImage"), for: UIControlState())
            
        }
    }
}
