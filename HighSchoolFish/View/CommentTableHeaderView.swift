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
    @IBOutlet weak var deleteButtonView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    private var section: Int = 0

    private var buttonAction: (() -> Void)?
    private var deleteAction: (() -> Void)?
    private var moreButtonAction: (() -> Void)?
    private var likeButtonAction: (() -> Void)?
    private var swipeAction: (() -> Void)?
    @IBOutlet weak var commentSwipeChangingConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewTrailingConstraint: NSLayoutConstraint!
    
    private var isViewOpen: Bool = false
    
    override func awakeFromNib() {
        self.backgroundColor = .white
        self.deleteButtonView.isHidden = true
        
        
    }
    
    func commentWirteConfigure(section: Int, buttonAction: @escaping () -> Void) {
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
    
    func commentDeleteConfigure(section: Int, deleteAction: @escaping () -> Void) {
        self.section = section
        self.deleteAction = deleteAction
        
        deleteButton.addTarget(self, action: #selector(commentDeleteButtonTapped), for: .touchUpInside)
    }
    
    func swipeConfigure(section: Int, swipeAction: @escaping () -> Void) {
        self.section = section
        self.swipeAction = swipeAction
        let swipeGestrue = UISwipeGestureRecognizer(target: self, action: #selector(deleteCommentGesture))
        swipeGestrue.direction = .left
        
        self.addGestureRecognizer(swipeGestrue)
        
        let initCommentGesture = UISwipeGestureRecognizer(target: self, action: #selector(initCommentGestrue))
        initCommentGesture.direction = .right
        self.addGestureRecognizer(initCommentGesture)
    }
    
    @objc private func showMoreViewTapped() {
        print("more button tapped")
        moreButtonAction?()
    }
    
    @objc private func commentWriteButtonTapped() {
        // 클로저 내에 정의된 동작을 호출하면서 섹션 값을 전달합니다.
        print("ㅇ예?")
        buttonAction?()
        
    }
    
    @objc private func initCommentGestrue() {
        if self.deleteButtonView.isHidden == false {
            self.deleteButtonView.alpha = 1
            self.deleteButtonView.isHidden = true
            
            UIView.animate(withDuration: 0.5, animations: {
                self.deleteButtonView.alpha = 0
                // 초기 : profileImage leading +16
                // left swipe : profileImage leading -60
                if self.commentSwipeChangingConstraint?.constant == -60 {
                    // 초기 제약조건 설정
                    self.commentSwipeChangingConstraint.constant = 16
                    self.stackViewTrailingConstraint.constant = 10
                }
            }, completion: { _ in
                
            })
        }
    }
    
    @objc private func deleteCommentGesture() {
        // isHidden 상태를 변경하기 전에 뷰의 투명도를 설정
        if self.deleteButtonView.isHidden {
            self.deleteButtonView.alpha = 0
            self.deleteButtonView.isHidden = false
            
            // 애니메이션 블록 안에서 투명도를 애니메이션 함
            UIView.animate(withDuration: 0.5, animations: {
                // 삭제 버튼을 보여주기 위해 알파 값을 1로 설정
                self.deleteButtonView.alpha = 1
                
                if self.commentSwipeChangingConstraint?.constant == 16 {
                    // 초기 제약조건 설정
                    self.commentSwipeChangingConstraint.constant = -60
                    self.stackViewTrailingConstraint.constant = -90
                }
            }, completion: { _ in
                // 애니메이션 완료 후, 필요한 추가 작업을 수행할 수 있습니다.
            })
        }
        
        swipeAction?()
    }
    
    @objc private func commentDeleteButtonTapped() {
        print("comment Delete Button Tapped")
        deleteAction?()
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
        
        var timeLabelText = ""
        let givenTimeString = comment.createdAt
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        // 주어진 시간 문자열을 Date 객체로 변환
        if let givenDate = formatter.date(from: givenTimeString) {
            // 현재 날짜와 주어진 날짜의 차이 계산
            let now = Date()
            let calendar = Calendar.current
            
            // 날짜 차이 계산
            let components = calendar.dateComponents([.day, .hour], from: givenDate, to: now)
            
            if let daysAgo = components.day, daysAgo >= 1 {
                print("\(daysAgo)일 전")
                timeLabelText = "\(daysAgo)일 전"
            } else if let hoursAgo = components.hour {
                print("\(hoursAgo)시간 전")
                timeLabelText = "\(hoursAgo)시간 전"
            } else {
                print("방금 전")
                timeLabelText = "방금 전"
            }
        } else {
            print("날짜 형식이 잘못되었습니다.")
        }
        self.timeLabel.text = timeLabelText
        
        
        
        //        if comment.isWriter {
        //            // 본인이 단 댓글
        //        }
    }
}
