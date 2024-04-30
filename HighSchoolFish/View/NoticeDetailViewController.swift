//
//  NoticeDetailViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/17/24.
//

import Foundation
import UIKit
import SafeAreaBrush

class NoticeDetailViewController: UIViewController {
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(noticeTitleLabel)
        view.addSubview(noticeDateLabel)
        view.addSubview(lineView)
        view.addSubview(contentLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noticeDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lineGray")!.cgColor
        return view
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        configure()
        setAutoLayout()
    }
    
    private func configure() {
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.backgroundColor = .white
        NoticeViewModel.shared.getNoticeDetailResult = { result in
            self.setDetailNotice(notice: result)
        }
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            noticeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noticeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            noticeTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            noticeDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noticeDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            noticeDateLabel.topAnchor.constraint(equalTo: noticeTitleLabel.bottomAnchor, constant: 7),
            
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lineView.topAnchor.constraint(equalTo: noticeDateLabel.bottomAnchor, constant: 14),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setDetailNotice(notice: Notice) {
        print(notice)
        
        self.noticeTitleLabel.text = notice.data.title
        self.contentLabel.text = notice.data.context
        
        var timeLabelText = ""
        let givenTimeString = notice.data.createdAt
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
        
        self.noticeDateLabel.text = timeLabelText

    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
