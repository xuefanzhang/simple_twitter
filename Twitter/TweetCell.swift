//
//  TweetCell.swift
//  Twitter
//
//  Created by Xuefan Zhang on 10/4/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

protocol TweetCellDelegate {
    func didTapAvatarForUser(user: User?)
}

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var delegate: TweetCellDelegate?
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user!.name as? String!
            profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
            createdAtLabel.text = tweet.elapsedString
            contentLabel.text = tweet.text
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("profileImageTapped:"))
            profileImageView.userInteractionEnabled = true
            profileImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    func profileImageTapped(sender: UITapGestureRecognizer) {
        delegate?.didTapAvatarForUser(tweet.user)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
