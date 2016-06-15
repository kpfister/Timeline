//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Karl Pfister on 6/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    var post = Post()
    
    func updateWithPost(post: Post) {
        self.imageView?.image = post.photo
//        guard let data = post.photoData else {return}
//        postImageView.image = UIImage(data: data)
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
