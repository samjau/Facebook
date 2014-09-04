//
//  LoginViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/13/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var formContainerView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        loginButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        println("Keyboard will show")
        
        formContainerView.center.y -= 50
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        println("Keyboard will hide")
        
        formContainerView.center.y += 50
    }
    
    @IBAction func editingChanged(sender: AnyObject) {
        if emailField.text.isEmpty || passwordField.text.isEmpty {
            loginButton.enabled = false
        } else {
            loginButton.enabled = true
        }
    }

    @IBAction func onLoginButton(sender: AnyObject) {
        activityIndicatorView.startAnimating()
        loginButton.enabled = false
        delay(2) {
            self.activityIndicatorView.stopAnimating()
            self.loginButton.enabled = true
            
            if self.emailField.text == "user" && self.passwordField.text == "password" {
                self.performSegueWithIdentifier("signInSegue", sender: self)
            } else {
                UIAlertView(title: "Oops", message: "Wrong password", delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
