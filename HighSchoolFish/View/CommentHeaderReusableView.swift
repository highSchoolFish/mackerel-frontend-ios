//
//  CommentHeaderReusableView.swift
//  HighSchoolFish
//
//  Created by 강보현 on 11/14/23.
//

import UIKit

class CommentHeaderReusableView: UICollectionReusableView, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var showMoreView: UIView!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
        // no
        self.backgroundColor = .purple
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTap))
        showMoreView.addGestureRecognizer(gesture)
        self.addGestureRecognizer(gesture)
        showMoreButton.addGestureRecognizer(gesture)
        self.isUserInteractionEnabled = true
        showMoreView.isUserInteractionEnabled = true
        showMoreButton.isUserInteractionEnabled = true
    }
    
    @objc func viewTap() {
        print("view tapped")
        DetailBoardViewModel.shared.moreCommentButtonTapped()
        // Handle the tap gesture
    }
    
    
    func generateCell(comment: CommentContent) {
        print("generateCell header comment")
        
        if comment.profile == nil {
            profileImageView.image = UIImage(named: "pictureIcon")
        }
        nicknameLabel.text = comment.name
        timeLabel.text = comment.createdAt
        contextLabel.text = comment.context
        likeCountLabel.text = "\(comment.numberOfLikes)"
        
        if comment.childComments?.count == 0 {
            showMoreView.isHidden = true
        } else {
            showMoreView.isHidden = false
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


