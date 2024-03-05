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
    @IBOutlet weak var showMoreViewButton: UIButton!
    
    private var buttonAction: (() -> Void)?
    private var section: Int = 0
    
    private var moreButtonAction: (() -> Void)?
    private var likeButtonAction: (() -> Void)?
    private var isViewOpen: Bool = false
    
    override func awakeFromNib() {
        self.backgroundColor = .white
    }
    
    func configure(section: Int, buttonAction: @escaping () -> Void) {
        self.section = section
        self.buttonAction = buttonAction
        commentWriteButton.addTarget(self, action: #selector(commentWriteButtonTapped), for: .touchUpInside)
    }
    
    func moreButtonConfigure(section: Int, moreButtonAction: @escaping () -> Void) {
        self.section = section
        self.moreButtonAction = moreButtonAction
        showMoreViewButton.addTarget(self, action: #selector(showMoreViewTapped), for: .touchUpInside)
    }
    
    func likeButtonConfigure(section: Int, likeButtonAction: @escaping () -> Void) {
        self.section = section
        self.likeButtonAction = likeButtonAction
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func showMoreViewTapped() {
        print("more button tapped")
        moreButtonAction?()
//        // 답글 n개
//        if showMoreViewButton.titleLabel.text == "답글 숨기기" {
//            showMoreViewButton.titleLabel?.text = "답글 \()개"
//        }
//        
        // 답글 숨기기
    }
    
    @objc private func commentWriteButtonTapped() {
        // 클로저 내에 정의된 동작을 호출하면서 섹션 값을 전달합니다.
        print("ㅇ예?")
        buttonAction?()
    }
    
    @objc private func likeButtonTapped()  {
        print("likeButtonTapped")
        likeButtonAction?()
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
