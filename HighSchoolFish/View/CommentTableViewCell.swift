//
//  CommentTableViewCell.swift
//  HighSchoolFish
//
//  Created by 강보현 on 11/28/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentWriteButton: UIButton!
    @IBOutlet weak var deleteButtonView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var buttonAction: (() -> Void)?
    private var deleteAction: (() -> Void)?
    private var likeButtonAction: (() -> Void)?
    private var section: Int = 0
    private var swipeAction: (() -> Void)?
    @IBOutlet weak var commentSwipeChangingConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewTrailingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.deleteButtonView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            // 셀이 선택되었을 때의 동작
        } else {
            // 셀이 선택 해제되었을 때의 동작
            self.contentView.backgroundColor = UIColor.white
        }
        // Configure the view for the selected state
    }
    
    func commentWriteConfigure(section: Int, buttonAction: @escaping () -> Void) {
        self.section = section
        self.buttonAction = buttonAction
        commentWriteButton.addTarget(self, action: #selector(commentWriteButtonTapped), for: .touchUpInside)
    }
    
    func commentDeleteConfigure(indexPath: IndexPath, deleteAction: @escaping () -> Void) {
        self.section = indexPath.section
        self.deleteAction = deleteAction
        
        deleteButton.addTarget(self, action: #selector(commentDeleteButtonTapped), for: .touchUpInside)
    }
    
    func likeButtonConfigure(section: Int, likeButtonAction: @escaping () -> Void) {
        self.section = section
        self.likeButtonAction = likeButtonAction
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    func swipeConfigure(indexPath: IndexPath, swipeAction: @escaping () -> Void) {
        
        self.section = indexPath.section
        self.swipeAction = swipeAction
        let swipeGestrue = UISwipeGestureRecognizer(target: self, action: #selector(deleteChildCommentGesture))
        swipeGestrue.direction = .left
        
        self.addGestureRecognizer(swipeGestrue)
        
        let initCommentGesture = UISwipeGestureRecognizer(target: self, action: #selector(initCommentGestrue))
        initCommentGesture.direction = .right
        self.addGestureRecognizer(initCommentGesture)
    }
    
    @objc private func initCommentGestrue() {
        if self.deleteButtonView.isHidden == false {
            self.deleteButtonView.alpha = 1
            self.deleteButtonView.isHidden = true
            
            UIView.animate(withDuration: 0.5, animations: {
                self.deleteButtonView.alpha = 0
                if self.commentSwipeChangingConstraint?.constant == -40 {
                    // 초기 제약조건 설정
                    self.commentSwipeChangingConstraint.constant = 40
                    self.stackViewTrailingConstraint.constant = 10
                }
            }, completion: { _ in
                
            })
        }
        
        
    }
    
    @objc private func deleteChildCommentGesture() {
        // isHidden 상태를 변경하기 전에 뷰의 투명도를 설정
        if self.deleteButtonView.isHidden {
            self.deleteButtonView.alpha = 0
            self.deleteButtonView.isHidden = false
            // 애니메이션 블록 안에서 투명도를 애니메이션 함
            UIView.animate(withDuration: 0.5, animations: {
                // 삭제 버튼을 보여주기 위해 알파 값을 1로 설정
                self.deleteButtonView.alpha = 1
                if self.commentSwipeChangingConstraint?.constant == 40 {
                    // 초기 제약조건 설정
                    self.commentSwipeChangingConstraint.constant = -40
                    self.stackViewTrailingConstraint.constant = -90
                }
            }, completion: { _ in
                // 애니메이션 완료 후, 필요한 추가 작업을 수행할 수 있습니다.
            })
        }
        
        swipeAction?()
    }
    
    @objc private func commentWriteButtonTapped() {
        // 클로저 내에 정의된 동작을 호출하면서 섹션 값을 전달합니다.
        buttonAction?()
    }
    
    @objc private func commentDeleteButtonTapped() {
        print("comment Delete Button Tapped")
        deleteAction?()
    }
    
    @objc private func likeButtonTapped() {
        print("like Button Tapped")
        likeButtonAction?()
    }
    
    func generateCell(comment: CommentContent) {
        print("generateCell comment")
        
        self.backgroundColor = .white
        
        if comment.profile == nil {
            profileImage.image = UIImage(named: "profileIcon")
        }
        nameLabel.text = comment.name
        timeLabel.text = comment.createdAt
        contextLabel.text = comment.context
        likeCountLabel.text = "\(comment.numberOfLikes)"
        
        var timeLabelText = ""
        let givenTimeString = comment.createdAt
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS" // 분수초를 포함한 날짜 형식 지정
        formatter.locale = Locale(identifier: "en_US_POSIX") // 24시간제 지정
        formatter.timeZone = TimeZone.current //

        if let date = formatter.date(from: givenTimeString) {
            // 현재 날짜와 주어진 날짜의 차이 계산
            print("date \(date)")
            let now = Date()
            let calendar = Calendar.current

            // 날짜 차이 계산
            let components = calendar.dateComponents([.day, .hour, .minute], from: date, to: now)
            
            if let daysAgo = components.day, daysAgo > 0 {
                timeLabelText = "\(daysAgo)일 전"
            } else if let hoursAgo = components.hour, hoursAgo > 0 {
                timeLabelText = "\(hoursAgo)시간 전"
            } else if let minutesAgo = components.minute, minutesAgo > 0 {
                timeLabelText = "\(minutesAgo)분 전"
            } else {
                timeLabelText = "방금 전"
            }
        } else {
            print("날짜 형식이 잘못되었습니다.")
        }

        self.timeLabel.text = timeLabelText
        
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
