//
//  ArtistDetailViewButton.swift
//  YFF2016
//
//  Created by Isaac Norman on 19/02/2016.
//  Copyright © 2016 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class ArtistDetailViewButton: UIButton {
    let screenWidth = UIScreen.main.bounds.width
    
    var lineView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Text Color
        self.tintColor = UIColor.black
        
        // Font
        self.titleLabel?.font = UIFont(name: "BebasNeueRegular", size: 18)
        
        //Background
        self.backgroundColor = UIColor.white
        
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 0.5
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
        
    }
    
    func setAsActive() {
        setUnderline()
        self.tintColor = YFFOlive
    }
    
    func setAsInactive() {
        removeUnderline()
        self.tintColor = UIColor.black
    }
    
    func setUnderline() {
        let lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 3))
        removeUnderline()
        lineView.backgroundColor = YFFOlive
        lineView.tag = 100
        self.addSubview(lineView)
        self.lineView = lineView
    }
    
    func removeUnderline() {
       self.viewWithTag(100)?.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.lineView?.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 3)
    }
    
}
