//
//  MVSubredditTableViewCell.swift
//  RedditObjC
//
//  Created by Markus Varner on 9/12/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class MVSubredditTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var subredditImageView: UIImageView!
    
     //MARK: - Properties
    
    var subreddit: MVSubreddit? {
        didSet{
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    func updateView() {
        guard let subreddit = subreddit else{return}
        titleLabel.text = subreddit.title
        likesLabel.text = "👍🏻 \(subreddit.likeCount)"
        commentsLabel.text = "💬 \(subreddit.commentCount)"
        subredditImageView.image = subreddit.photo
    }
}
