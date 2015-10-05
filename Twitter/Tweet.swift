//
//  Tweet.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/4/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var elapsedString: String?
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        let formatter2 = NSDateComponentsFormatter()
        formatter2.unitsStyle = NSDateComponentsFormatterUnitsStyle.Abbreviated
        formatter2.collapsesLargestUnit = true
        formatter2.maximumUnitCount = 1
        let interval = NSDate().timeIntervalSinceDate(createdAt!)
        elapsedString = formatter2.stringFromTimeInterval(interval)!
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
