//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/4/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var newTweetTextField: UITextField!
    
    @IBAction func onTweet(sender: AnyObject) {
        let status = self.newTweetTextField.text
        if status == "" {
            return
        }
        
        let params: NSDictionary = [
            "status": status!
        ]
        
        TwitterClient.sharedInstance.postTweetWithParams(params, completion: { (tweet, error) -> () in
            if error != nil {
                print(error)
                return
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
