//
//  MapViewController.swift
//  YFF2016
//
//  Created by Isaac Norman on 21/12/2015.
//  Copyright © 2015 Yackandandah Folk Festival. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class MapViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    
    var mapImageView: UIImageView!
    
    let enhanceFactor: CGFloat = 1.75
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Controller

        self.navigationItem.title = "EVENT MAP"
        self.navigationController?.navigationBar.barTintColor = YFFOrange

        
        //Set up the image inside the scroll view
        let mapImage = UIImage(named: "mapImage")
        mapImageView = UIImageView(image: mapImage)
        mapImageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: (mapImage?.size)!)
        scrollView.addSubview(mapImageView)
        
        // Set the scroll view to cover the whole image
        scrollView.contentSize = mapImage!.size
        
        // Set the double tap gesture on the scroll view
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.scrollViewDoubleTapped(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.scrollViewTapped))
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup Tab Bar
        self.tabBarController!.tabBar.tintColor = YFFOrange
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImageView
    }
    
    // Helper method for centering the image
    func centerScrollViewContents() {
        var contentsFrame = mapImageView.frame

        contentsFrame.origin.x = 0.0

        contentsFrame.origin.y = 0.0
        
        mapImageView.frame = contentsFrame
    }
    
    // Is the tab bar visible?
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < self.view.frame.maxY
    }
    
    
    // Hide the tab bar when scrolling around
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            setTabBarVisible(false, animated: true)
    }
    
    // Toggle the tab bar on tap
    @objc func scrollViewTapped() {
        setTabBarVisible(!tabBarIsVisible(), animated: true)
    }
    
    
    // Function to handle hiding and showing the tab bar
    func setTabBarVisible(_ visible:Bool, animated:Bool) {
        
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration:TimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration, animations: {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }) 
        }
    }
    
    // Zoom in on the desired area when double tapped
    @objc func scrollViewDoubleTapped(_ recognizer: UITapGestureRecognizer) {
        
        // Hide the tab bar
        setTabBarVisible(false, animated: true)
        
        
        // Where are we zooming to?
        let pointInView = recognizer.location(in: mapImageView)
        
        // How far are we zooming?
        var newZoomScale = scrollView.zoomScale * enhanceFactor
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        // What do we want to show?
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h);
        
        // Do it!
        scrollView.zoom(to: rectToZoomTo, animated: true)
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
