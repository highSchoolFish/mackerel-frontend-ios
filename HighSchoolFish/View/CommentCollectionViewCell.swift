//
//  CommentCollectionViewCell.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/11/23.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .brown

    }
    
    func generateCell(comment: CommentContent) {
        print("generateCell comment")
        self.backgroundColor = .green

        if comment.profile == nil {
            profileImageView.image = UIImage(named: "pictureIcon")
        }
        nicknameLabel.text = comment.name
        timeLabel.text = comment.createdAt
        contextLabel.text = comment.context
        likeCountLabel.text = "\(comment.numberOfLikes)"
        
        if comment.childComments != nil {
//            if comment.childComments!.count >= 1 {
//                showCommentView.isHidden = false
//            }
//            else {
//                showCommentView.isHidden = true
//            }
        }
//        if comment.isLike == false {
//            // 좋아요 안눌려있음
//            likeButton.tintColor = UIColor(named: "gray")
//        }
//        else {
//            likeButton.tintColor = UIColor(named: "red")
//        }
        
//        if comment.isWriter {
//            // 본인이 단 댓글
//        }
    }
    
    
    
}
