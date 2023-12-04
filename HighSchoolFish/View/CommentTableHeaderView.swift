//
//  CommentHeaderView.swift
//  HighSchoolFish
//
//  Created by 강보현 on 11/29/23.
//

import Foundation

class CommentTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentWriteButton: UIButton!
    @IBOutlet weak var showMoreView: UIView!
    
    override func awakeFromNib() {
        
    }
}
