//
//  SettingTabViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/19.
//

import Foundation
import UIKit
import SwiftUI
import SafeAreaBrush

class MyPageTabViewController: UIViewController {
    
    private lazy var navigationBar: UINavigationBar = {
        let naviBar = UINavigationBar()
        naviBar.translatesAutoresizingMaskIntoConstraints = false
        naviBar.tintColor = .white
        naviBar.backgroundColor = UIColor(named:"main")
        naviBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviBar.shadowImage = UIImage()
        let naviTitleItem = UINavigationItem(title: "")
        let customBarButtonItem = UIBarButtonItem(customView: self.naviTitleLabel)
        
        naviTitleItem.leftBarButtonItems = [customBarButtonItem]
        
        naviBar.items = [naviTitleItem]
        return naviBar
    }()
    
    private lazy var naviTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.text = "가나고등학교"
        label.textColor = UIColor(named: "darkGray")
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gradeLabel: UILabel = {
        let label = UILabel()
        label.text = "몇학년"
        label.textColor = UIColor(named: "darkGray")
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editIcon"), for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var line1View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lineGray")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var boardlabel: UILabel = {
        let label = UILabel()
        label.text = "나의 게시물"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeBoardLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 게시판"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeBoardView: UIView = {
        let view = UIView()
        view.addSubview(likeBoardLabel)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(likeBoardViewTapped))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var myBoardLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 작성한 게시판"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myBoardView: UIView = {
        let view = UIView()
        view.addSubview(myBoardLabel)
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(myBoardViewTapped))
        view.addGestureRecognizer(gesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var line2View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lineGray")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.text = "알림"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var alertSwitch: UISwitch = {
        let alertSwitch = UISwitch()
        alertSwitch.tintColor = UIColor(named: "main")
        alertSwitch.addTarget(self, action: #selector(onClickSwitch), for: .valueChanged)
        alertSwitch.translatesAutoresizingMaskIntoConstraints = false
        return alertSwitch
    }()
    
    private lazy var changeSchoolLabel: UILabel = {
        let label = UILabel()
        label.text = "학교 변경"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var changeSchoolView: UIView = {
        let view = UIView()
        view.addSubview(changeSchoolLabel)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeSchoolViewTapped))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noticeView: UIView = {
        let view = UIView()
        view.addSubview(noticeLabel)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(noticeListViewTapped))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutoLayout()
        
        setMyInfo()
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 150),
            topView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
            
            schoolNameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 50),
            schoolNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            gradeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gradeLabel.topAnchor.constraint(equalTo: schoolNameLabel.bottomAnchor, constant: 10),
            
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40),
            profileImageView.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: 10),
            
            nicknameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nicknameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            
            editButton.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor, constant: 0),
            editButton.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 10),
            
            line1View.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            line1View.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            line1View.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 40),
            line1View.heightAnchor.constraint(equalToConstant: 1),
            
            boardlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            boardlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            boardlabel.topAnchor.constraint(equalTo: line1View.bottomAnchor, constant: 16),
            
            likeBoardView.topAnchor.constraint(equalTo: boardlabel.bottomAnchor, constant: 20),
            likeBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            likeBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            likeBoardView.heightAnchor.constraint(equalToConstant: 30),
            
            likeBoardLabel.leadingAnchor.constraint(equalTo: likeBoardView.leadingAnchor, constant: 0),
            likeBoardLabel.trailingAnchor.constraint(equalTo: likeBoardView.trailingAnchor, constant: 0),
            likeBoardLabel.topAnchor.constraint(equalTo: likeBoardView.topAnchor, constant: 0),
            likeBoardLabel.bottomAnchor.constraint(equalTo: likeBoardView.bottomAnchor, constant: 0),
            
            myBoardView.topAnchor.constraint(equalTo: likeBoardView.bottomAnchor, constant: 20),
            myBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            myBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            myBoardView.heightAnchor.constraint(equalToConstant: 30),
            
            myBoardLabel.leadingAnchor.constraint(equalTo: myBoardView.leadingAnchor, constant: 0),
            myBoardLabel.trailingAnchor.constraint(equalTo: myBoardView.trailingAnchor, constant: 0),
            myBoardLabel.topAnchor.constraint(equalTo: myBoardView.topAnchor, constant: 0),
            myBoardLabel.bottomAnchor.constraint(equalTo: myBoardView.bottomAnchor, constant: 0),
            
            line2View.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            line2View.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            line2View.heightAnchor.constraint(equalToConstant: 1),
            line2View.topAnchor.constraint(equalTo: myBoardView.bottomAnchor, constant: 16),
            
            alertLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            alertLabel.topAnchor.constraint(equalTo: line2View.bottomAnchor, constant: 16),
            
            alertSwitch.centerYAnchor.constraint(equalTo: alertLabel.centerYAnchor, constant: 0),
            alertSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            changeSchoolView.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 20),
            changeSchoolView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            changeSchoolView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            changeSchoolView.heightAnchor.constraint(equalToConstant: 30),
            
            changeSchoolLabel.leadingAnchor.constraint(equalTo: changeSchoolView.leadingAnchor, constant: 0),
            changeSchoolLabel.trailingAnchor.constraint(equalTo: changeSchoolView.trailingAnchor, constant: 0),
            changeSchoolLabel.topAnchor.constraint(equalTo: changeSchoolView.topAnchor, constant: 0),
            changeSchoolLabel.bottomAnchor.constraint(equalTo: changeSchoolView.bottomAnchor, constant: 0),
            
            noticeView.topAnchor.constraint(equalTo: changeSchoolView.bottomAnchor, constant: 20),
            noticeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noticeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noticeView.heightAnchor.constraint(equalToConstant: 30),
            
            noticeLabel.leadingAnchor.constraint(equalTo: changeSchoolView.leadingAnchor, constant: 0),
            noticeLabel.trailingAnchor.constraint(equalTo: changeSchoolView.trailingAnchor, constant: 0),
            noticeLabel.topAnchor.constraint(equalTo: noticeView.topAnchor, constant: 0),
            noticeLabel.bottomAnchor.constraint(equalTo: noticeView.bottomAnchor, constant: 0),
        ])
    }
    
    private func configure() {
        view.backgroundColor = .white
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        
        view.addSubview(navigationBar)
        view.addSubview(topView)
        view.addSubview(schoolNameLabel)
        view.addSubview(gradeLabel)
        view.addSubview(profileImageView)
        view.addSubview(nicknameLabel)
        view.addSubview(editButton)
        view.addSubview(line1View)
        view.addSubview(boardlabel)
        view.addSubview(likeBoardView)
        view.addSubview(myBoardView)
        view.addSubview(line2View)
        view.addSubview(alertLabel)
        view.addSubview(alertSwitch)
        view.addSubview(changeSchoolView)
        view.addSubview(noticeView)
    }
    
    @objc func editButtonTapped() {
        let nextVC = MyPageEditViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc func likeBoardViewTapped() {
        print("like Board View Tapped")
        let nextVC = LikeBoardViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc func myBoardViewTapped() {
        let nextVC = MyBoardViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc func changeSchoolViewTapped() {
        let nextVC = EditSchoolViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc func noticeListViewTapped() {
        let nextVC = NoticeListViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc func onClickSwitch(sender: UISwitch) {
        if sender.isOn {
            MyPageViewModel.shared.alertSwitch(isOn: true)
        }
        else {
            MyPageViewModel.shared.alertSwitch(isOn: false)
        }
    }
    
    private func setMyInfo() {
        let nickname = MemberInfoViewModel.shared.userNicknameString
        let schoolName = MemberInfoViewModel.shared.userSchoolNameString
        let userGrade = MemberInfoViewModel.shared.userGradeString
        let userProfile = MemberInfoViewModel.shared.userProfileString
        
        self.nicknameLabel.text = "\(nickname)"
        
        if userProfile == "" {
            self.profileImageView.image = UIImage(named: "profileIcon")
        }
        else {
            // userProfile 기본 아닌 경우
        }
        
        if userGrade == "HIGH_FIRST" {
            self.gradeLabel.text = "1학년"
        }else if userGrade == "HIGH_SECOND" {
            self.gradeLabel.text = "2학년"
        }else if userGrade == "HIGH_THIRD" {
            self.gradeLabel.text = "3학년"
        }
        
        self.schoolNameLabel.text = schoolName
    }
    
    
}
