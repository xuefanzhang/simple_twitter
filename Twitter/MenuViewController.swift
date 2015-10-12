//
//  MenuViewController.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/11/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var profileViewController: UIViewController!
    private var tweetsNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController")
        tweetsNavigationController = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController")
        mentionsNavigationController = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController")
        
        viewControllers.append(profileViewController)
        viewControllers.append(tweetsNavigationController)
        viewControllers.append(mentionsNavigationController)
        
        hamburgerViewController?.contentViewController = tweetsNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        let titles = ["Profile", "Tweets", "Mentions"]
        cell.menuTitleLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let contentViewController = viewControllers[indexPath.row] as? ProfileViewController {
            contentViewController.handleName = User.currentUser?.screenname
        }
        
        hamburgerViewController?.contentViewController = viewControllers[indexPath.row]
    }


}
