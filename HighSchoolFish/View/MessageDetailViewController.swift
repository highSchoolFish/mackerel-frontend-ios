//
//  MessageDetailViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 5/30/24.
//

import UIKit
import SafeAreaBrush
import Foundation

class MessageDetailViewController: UIViewController, UITextFieldDelegate {
    private lazy var navigationBar: UINavigationBar = {
        let naviBar = UINavigationBar()
        naviBar.translatesAutoresizingMaskIntoConstraints = false
        naviBar.tintColor = .white
        naviBar.backgroundColor = UIColor(named:"main")
        naviBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviBar.shadowImage = UIImage()
        let naviTitleItem = UINavigationItem(title: "")
        let customBarButtonItem = UIBarButtonItem(customView: self.naviTitleLabel)
        
        naviTitleItem.leftBarButtonItems = [backButton]
        naviBar.items = [naviTitleItem]
        return naviBar
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let backImage = UIImage(named: "backButton")!
        let button = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        return button
    }()
    
    private lazy var naviTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "쪽지"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.addSubview(profileImageView)
        view.addSubview(nicknameLabel)
        view.addSubview(schoolLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileImageView: UIView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임자리요"
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "학교이름자리요"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var messageTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MessageListTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var bottomLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.addSubview(messageTextField)
        view.addSubview(messageUploadButton)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "내용을 입력해주세요."
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.isEnabled = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var messageUploadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uploadCircleIcon"), for: .normal)
//        button.addTarget(self, action: #selector(messageUploadButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutoLayout()
    }
    
    private func configure() {
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(topView)
        view.addSubview(topLineView)
        view.addSubview(messageTableView)
        view.addSubview(bottomLineView)
        view.addSubview(bottomView)
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0),
            profileImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0),
            profileImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            nicknameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0),
            nicknameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0),
            
            schoolLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            schoolLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            schoolLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0),
            
            topLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topLineView.heightAnchor.constraint(equalToConstant: 1),
            topLineView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            
            messageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            messageTableView.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 5),
            
            messageTableView.bottomAnchor.constraint(equalTo: bottomLineView.topAnchor, constant: 5),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomView.heightAnchor.constraint(equalToConstant: 60),
            
            bottomLineView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
            bottomLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bottomLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1),
            
            messageTextField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 0),
            messageTextField.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0),
            messageTextField.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0),
            messageTextField.trailingAnchor.constraint(equalTo: messageUploadButton.leadingAnchor, constant: -10),
            messageUploadButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
            messageUploadButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 5),
            messageUploadButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0),
            messageUploadButton.heightAnchor.constraint(equalToConstant: 50),
            messageUploadButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension MessageDetailViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("messageList Count \(5)")
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("messageList cellForRowAt)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageListTableViewCell", for: indexPath)as? MessageListTableViewCell else{
            print("cell error")
            return .init()
        }
        print("print cell index \(cell.index)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell selected rowAt \(indexPath)")
//        NoticeViewModel.shared.setNoticeIdString(noticeList[indexPath.item].id)
//        NoticeViewModel.shared.getNoticeDetail()
//        NoticeViewModel.shared.getNoticeDetailComplete = { result in
//            if result {
//                print("result true")
//                let vc = NoticeDetailViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
