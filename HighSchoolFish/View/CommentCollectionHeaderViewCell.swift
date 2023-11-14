//
//  CommentCollectionViewCell.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/11/23.
//

import UIKit

class CommentCollectionHeaderViewCell: UICollectionReusableView {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var showCommentView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func generateCell(comment: Comment) {
        print("generateCell header comment")
        nicknameLabel.text = comment.name
        contextLabel.text = comment.context
        
        
    }
    
}
