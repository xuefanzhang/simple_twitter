//
//  ViewController.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/2/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        print("login button pressed")
        if User.currentUser == nil {
            TwitterClient.sharedInstance.loginWithCompletion() {
                (user: User?, error: NSError?) in
                if user != nil {
                    // perform segue
                    NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: nil)
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                } else {
                    print("user is nil :(")
                    //handle error
                }
            }
        }
    }
}
