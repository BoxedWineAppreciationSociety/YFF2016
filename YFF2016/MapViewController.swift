//
//  MapViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 21/12/2015.
//  Copyright © 2015 Yackandandah Folk Festival. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    
    var mapImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the image inside the scroll view
        let mapImage = UIImage(named: "mapImage")
        mapImageView = UIImageView(image: mapImage)
        mapImageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: (mapImage?.size)!)
        scrollView.addSubview(mapImageView)
        
        // Set the scroll view to cover the whole image
        scrollView.contentSize = mapImage!.size
        
        // Set the double tap gesture on the scroll view
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewTapped")
        singleTapRecognizer.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTapRecognizer)
        
        // Set the initial size of the scrollView
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = minScale;
        
        // Set max and min zoom
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale;
        
        // Start at the center
        centerScrollViewContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return mapImageView
    }
    
    // Helper method for centering the image
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = mapImageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        mapImageView.frame = contentsFrame
    }
    
    // Is the tab bar visible?
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }
    
    
    // Hide the tab bar when scrolling around
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
            setTabBarVisible(false, animated: true)
    }
    
    // Toggle the tab bar on tap
    func scrollViewTapped() {
        setTabBarVisible(!tabBarIsVisible(), animated: true)
    }
    
    
    // Function to handle hiding and showing the tab bar
    func setTabBarVisible(visible:Bool, animated:Bool) {
        
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
                return
            }
        }
    }
    
    // Zoom in on the desired area when double tapped
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        
        // Hide the tab bar
        setTabBarVisible(false, animated: true)
        
        
        // Where are we zooming to?
        let pointInView = recognizer.locationInView(mapImageView)
        
        // How far arewe zooming?
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        // What do we want to show?
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // Do it!
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
