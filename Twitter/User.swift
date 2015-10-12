//
//  User.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/4/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var numberOfTweets: Int?
    var numberOfFollowing: Int?
    var numberOfFollowers: Int?
    var dictionary: NSDictionary
    
    override var description: String {
        return "name: \(name!)\n screenname: \(screenname!)"
    }
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        print(dictionary)
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileImageStr = dictionary["profile_image_url"] as? NSString
        profileImageUrl = profileImageStr?.stringByReplacingOccurrencesOfString("_normal", withString: "")
        tagline = dictionary["description"] as? String
        numberOfTweets = dictionary["statuses_count"] as? Int
        numberOfFollowers = dictionary["followers_count"] as? Int
        numberOfFollowing = dictionary["friends_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = try! NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

}
