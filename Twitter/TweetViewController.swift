//
//  TweetViewController.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/5/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    var tweet: Tweet?
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        print("onRetweet")
    }
    @IBAction func onFavorite(sender: AnyObject) {
        print("onFavorite")
    }
    @IBAction func onReply(sender: AnyObject) {
        print("onReply")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tweet != nil {
            nameLabel.text = tweet!.user!.name as? String!
            profileImageView.setImageWithURL(NSURL(string: tweet!.user!.profileImageUrl!))
            createdAtLabel.text = tweet!.createdAtString
            contentLabel.text = tweet!.text
        }
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
