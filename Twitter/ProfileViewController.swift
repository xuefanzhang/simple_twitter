//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/11/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetNumberLabel: UILabel!
    @IBOutlet weak var followingNumberLabel: UILabel!
    @IBOutlet weak var followerNumberLabel: UILabel!
    
    var handleName: String? {
        didSet {
            if isViewLoaded() {
                handleLabel.text = handleName
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLabel.text = handleName
        // Do any additional setup after loading the view.
        print("inside profile viewDidLoad")
        let params: NSDictionary = ["screen_name": handleName!]
        TwitterClient.sharedInstance.getUserProfile(params, completion: { (user, error) -> () in
            if user != nil {
                print(user)
                self.nameLabel.text = user!.name
                self.profileImageView.setImageWithURL(NSURL(string: user!.profileImageUrl!))
                self.tweetNumberLabel.text = String(user!.numberOfTweets!)
                self.followingNumberLabel.text = String(user!.numberOfFollowing!)
                self.followerNumberLabel.text = String(user!.numberOfFollowers!)
                return
            } else {
                print(error)
            }
        })
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
