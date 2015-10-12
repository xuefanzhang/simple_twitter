//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/4/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fetchTweets", name: userDidLoginNotification, object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetchTweets", forControlEvents: UIControlEvents.ValueChanged)
        
        let dummyTableVC = UITableViewController()
        dummyTableVC.tableView = tableView
        dummyTableVC.refreshControl = refreshControl
        
        fetchTweets()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchTweets() {
        if User.currentUser != nil {
            print("inside fetchTweets")
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let controller = storyboard.instantiateViewControllerWithIdentifier("TweetViewController") as! TweetViewController
        controller.tweet = self.tweets![indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    @IBAction func onNew(sender: AnyObject) {
        self.performSegueWithIdentifier("newTweetSegue", sender: self)
    }
    
    // MARK: TweetCellDelegate
    
    func didTapAvatarForUser(user: User?) {
        let profileVC = storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        profileVC.handleName = user?.screenname
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}
