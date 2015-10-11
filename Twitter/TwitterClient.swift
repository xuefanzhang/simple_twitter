//
//  TwitterClient.swift
//  Twitter
//
//  Created by Xuefan Zhang on 9/29/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

let twitterConsumerKey = "zCpy2KkeYcEy0SZBkhVpkQfzt"
let twitterConsumerSecret = "lahiAFG3Qey8rPpUEGF3SrDKNDMXjKzfdmcpXMHEOLTwPp7fUv"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user:User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            print("error getting home timeline")
            completion(tweets:nil, error: error)
        })
    }
    
    func postTweetWithParams(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()){
        self.POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var status = Tweet(dictionary: response as! NSDictionary)
            completion(tweet: status, error: nil)
        }) {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            print("error posting status")
            completion(tweet: nil, error: error)
        }
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("got request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
        }) {(error: NSError!) -> Void in
            print("failed")
            self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error getting current user")
                self.loginCompletion?(user: nil, error: error)
            })
        }) { (error: NSError!) -> Void in
            print("failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }
        
    }
}
