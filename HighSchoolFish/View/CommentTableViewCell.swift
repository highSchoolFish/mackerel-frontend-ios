//
//  CommentTableViewCell.swift
//  HighSchoolFish
//
//  Created by 강보현 on 11/28/23.
//

import UIKit

protocol TappedLikeButtonDelegate: AnyObject {
    // 위임해줄 기능
    func likeButtonTapped()
}

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentWriteButton: UIButton!

    var delegate: TappedLikeButtonDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.likeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
                    // 셀이 선택되었을 때의 동작
                    self.contentView.backgroundColor = UIColor.blue
                } else {
                    // 셀이 선택 해제되었을 때의 동작
                    self.contentView.backgroundColor = UIColor.white
                }
        // Configure the view for the selected state
    }
    
    @objc func buttonTapped() {
        delegate?.likeButtonTapped()
    }
    
    
    func generateCell(comment: CommentContent) {
        print("generateCell comment")
        
        self.backgroundColor = .green

        if comment.profile == nil {
            profileImage.image = UIImage(named: "profileIcon")
        }
        nameLabel.text = comment.name
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
