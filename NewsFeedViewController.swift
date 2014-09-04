//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    @IBOutlet var containerView: UIView!
    var isPresenting: Bool = true

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    var imgWidth: CGFloat = 0
    var imgHeight: CGFloat = 0

    var tmpImage : UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
        // Manually create your views programatically
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var x: CGFloat = 2.0
        
        x = x + 0.7
        
        // Configure the content size of the scroll view
        scrollView.contentSize = CGSize(width: 320, height: feedImageView.image.size.height)
        
        delay(2, closure: {
            self.scrollView.hidden = false
            self.activityIndicator.stopAnimating()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        destinationViewController.image = tmpImage.image
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
    
    }
    
    @IBAction func photoSegue(sender: UITapGestureRecognizer) {
        tmpImage = sender.view as UIImageView
        performSegueWithIdentifier("PhotoViewSegue", sender: self)
        
    }
    

    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        var window = UIApplication.sharedApplication().keyWindow
        var frame = window.convertRect(tmpImage.frame, fromView: scrollView)
        var animateImgView = UIImageView(frame: frame)
        animateImgView.image = tmpImage.image

        
        
        if (isPresenting == true){
            window.addSubview(animateImgView)
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: nil, animations: {
                
                animateImgView.frame.size.width = 320
                animateImgView.frame.size.height = 568
                animateImgView.contentMode = UIViewContentMode.ScaleAspectFit
                animateImgView.center.x = 160
                animateImgView.center.y = 284
                self.imgWidth = animateImgView.image.size.width
                self.imgHeight = animateImgView.image.size.height
                
            }, completion: { (finished:Bool) in animateImgView.removeFromSuperview()})

            containerView.addSubview(toViewController.view)
            
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.removeFromParentViewController()
            }
            
        } else {
            window.addSubview(animateImgView)
            animateImgView.frame.size.width = imgWidth
            animateImgView.frame.size.height = imgHeight
            animateImgView.contentMode = UIViewContentMode.ScaleAspectFit
            animateImgView.clipsToBounds = true
            fromViewController.view.alpha = 0
            animateImgView.center.x = 160 - (fromViewController as PhotoViewController).scrollView.contentOffset.x
            animateImgView.center.y = 284 - (fromViewController as PhotoViewController).scrollView.contentOffset.y

            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: nil, animations: {
                animateImgView.frame.size.width = self.tmpImage.frame.size.width
                animateImgView.frame.size.height = self.tmpImage.frame.size.height
                println(self.tmpImage.frame.height)
                println(self.tmpImage.frame.width)
                animateImgView.contentMode = UIViewContentMode.ScaleAspectFill
                animateImgView.clipsToBounds = true
                animateImgView.center.x = self.tmpImage.center.x
                animateImgView.center.y = self.tmpImage.center.y+110
                }, completion: { (finished:Bool) in animateImgView.removeFromSuperview()
            })
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    fromViewController.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }

            
        }
    }
}
