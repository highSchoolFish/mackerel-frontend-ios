//
//  NoticeListViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/17/24.
//

import Foundation
import UIKit
import SafeAreaBrush

class NoticeListViewController: UIViewController {
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
    
    private lazy var noticeTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NoticeListTableViewCell", bundle: nil), forCellReuseIdentifier: "NoticeListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var noticeList: [NoticeListContent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        configure()
        setAutoLayout()
        
        setNoticeList()
    }
    
    private func configure() {
        view.addSubview(navigationBar)
        view.addSubview(noticeTableView)
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            noticeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noticeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noticeTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0),
            noticeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setNoticeList() {
        // noticeList Data통신 이후 List set
        NoticeViewModel.shared.getNoticeList()
        NoticeViewModel.shared.getNoticeListResult = { result in
            self.noticeList = result.data.content
            print("noticeList \(self.noticeList)")
            self.noticeTableView.reloadData()
        }
    }
}

extension NoticeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("noticeList Count \(noticeList.count)")
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("noticeList cellForRowAt)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeListTableViewCell", for: indexPath)as? NoticeListTableViewCell else{
            print("cell error")
            return .init()
        }
        cell.generateCell(notice: noticeList[indexPath.item])
        print("print cell index \(cell.index)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell selected rowAt \(indexPath)")
        NoticeViewModel.shared.setNoticeIdString(noticeList[indexPath.item].id)
        NoticeViewModel.shared.getNoticeDetail()
        NoticeViewModel.shared.getNoticeDetailComplete = { result in
            if result {
                print("result true")
                let vc = NoticeDetailViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
