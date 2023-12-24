//
//  CommentHeaderView.swift
//  HighSchoolFish
//
//  Created by 강보현 on 11/29/23.
//

import Foundation
import UIKit

class CommentTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentWriteButton: UIButton!
    @IBOutlet weak var showMoreView: UIView!
    private var buttonAction: (() -> Void)?
    private var section: Int = 0
    
    override func awakeFromNib() {
        self.backgroundColor = .white
        let gesture = UIGestureRecognizer(target: self, action: #selector(headerViewTapped))
        self.showMoreView.addGestureRecognizer(gesture)
    }
    
    func configure(section: Int, buttonAction: @escaping () -> Void) {
        self.section = section
        self.buttonAction = buttonAction
        commentWriteButton.addTarget(self, action: #selector(commentWriteButtonTapped), for: .touchUpInside)
        // 나머지 UI 구성
    }
    
    @objc private func commentWriteButtonTapped() {
        // 클로저 내에 정의된 동작을 호출하면서 섹션 값을 전달합니다.
        buttonAction?()
    }
    
    @objc func headerViewTapped() {
        print("headerViewTapped")
        // 추가적인 로직 처리
        DetailBoardViewModel.shared.moreCommentButtonTapped()
        DetailBoardViewModel.shared.onMoreCommentResult = { result in
            print("result")
            if result == false {
                // 답글 \()개 버튼 안눌림
                
            }
            else {
                // 눌림
                
            }
        }
    }
    
    @IBAction func headerLikeButtonTapped() {
        print("likeButtonTapped define on headerViewCustomClass")
    }
    
    func generateCell(comment: CommentContent) {
        print("generateCell comment")
        
        if comment.profile == nil {
            profileImage.image = UIImage(named: "profileIcon")
        }
        nameLabel.text = comment.name
        timeLabel.text = comment.createdAt
        contextLabel.text = comment.context
        likeCountLabel.text = "\(comment.numberOfLikes)"
        if comment.isLike == false {
            // 좋아요 안눌려있음
            likeButton.tintColor = UIColor(named: "gray")
        }
        else {
            likeButton.tintColor = UIColor(named: "red")
        }
        
        //        if comment.isWriter {
        //            // 본인이 단 댓글
        //        }
    }
    
    
}
