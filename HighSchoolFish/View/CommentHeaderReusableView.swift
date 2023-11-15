//
//  CommentHeaderReusableView.swift
//  HighSchoolFish
//
//  Created by 강보현 on 11/14/23.
//

import UIKit

class CommentHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var showCommentView: UIView!
    @IBOutlet weak var showCommentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    var buttonAction : (() -> Void) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showCommentButton.addTarget(self, action: #selector(self.moreCommentViewTapped), for: .touchUpInside)
    }
    
    
    func generateCell(comment: Comment) {
        print("generateCell header comment")
        
        if comment.profile == nil {
            profileImageView.image = UIImage(named: "profileIcon")
            
        }
        
//        if comment.isAnonymous == true {
//            // 익명
//            nicknameLabel.text = "익명"
//        }
//        else {
//            nicknameLabel.text = comment.name
//        }
        
        timeLabel.text = comment.createdAt
        contextLabel.text = comment.context
        
        
        
        if comment.childComments != nil {
//            if comment.childComments!.count >= 1 {
//                showCommentView.isHidden = false
//            }
//            else {
//                showCommentView.isHidden = true
//            }
        }
        
        if comment.isLike == false {
            // 좋아요 안눌려있음
            likeButton.tintColor = UIColor(named: "gray")
        }
        else {
            likeButton.tintColor = UIColor(named: "red")
        }
        
        if comment.isWriter {
            // 본인이 단 댓글
        }
    }

    
    @objc func moreCommentViewTapped(_ sender: UIButton) {
        print("more comment button tapped")
        buttonAction()
    }
}
