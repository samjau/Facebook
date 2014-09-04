//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Sam Jau on 9/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    var image: UIImage!
    var imagePos: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        photoImageView.image = image
        scrollView.contentSize = photoImageView.frame.size
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // This method is called as the user scrolls
        println(scrollView.contentOffset)
        var alpha = 1 - abs(scrollView.contentOffset.y * 0.01)
        scrollView.backgroundColor = UIColor(white: 0, alpha: alpha)
        doneButton.alpha = alpha
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            if (abs(scrollView.contentOffset.y) > 100) {
                dismissViewControllerAnimated(true, completion: nil)
            }

            // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
    }
    
    @IBAction func onDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
