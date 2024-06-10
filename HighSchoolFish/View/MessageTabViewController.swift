//
//  MessageViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/19.
//

import Foundation
import UIKit

class MessageTabViewController: UIViewController {
    private lazy var navigationBar: UINavigationBar = {
        let naviBar = UINavigationBar()
        naviBar.translatesAutoresizingMaskIntoConstraints = false
        naviBar.tintColor = .white
        naviBar.backgroundColor = UIColor(named:"main")
        naviBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviBar.shadowImage = UIImage()
        let naviTitleItem = UINavigationItem(title: "")
        let customBarButtonItem = UIBarButtonItem(customView: self.naviTitleLabel)
        
        naviTitleItem.leftBarButtonItems = [backButton, customBarButtonItem]
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
        label.text = "공지사항"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var messageListTableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MessageListTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var nothingLabel: UILabel = {
        let label = UILabel()
        label.text = "쪽지함이 비어있습니다."
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupAutolayout()
    }
    
    private func configure() {
        view.addSubview(navigationBar)
        view.addSubview(nothingLabel)
        view.addSubview(messageListTableView)
    }
    
    private func setupAutolayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            messageListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            messageListTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
            messageListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            nothingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            nothingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    private func setMessageList() {
//        MessageViewModel.shared.getMessageList()
//        MessageViewModel.shared.onMessageResult = { result in
//            if result.data. != 0 {
//              self.nothingLabel.isHidden = true
//            }
//            else {
//              self.nothingLabel.isHidden = false
//            }
//        }
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension MessageTabViewController:UITableViewDelegate, UITableViewDataSource {
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
