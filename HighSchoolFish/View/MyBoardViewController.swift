
//  likeBoardViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/9/24.
//

import Foundation
import UIKit
import SwiftUI
import SafeAreaBrush

class MyBoardViewController: UIViewController {
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
        label.text = "내가 작성한 게시판"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        
        
        segment.selectedSegmentTintColor = .clear
        
        // 배경 색 제거
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        // Segment 구분 라인 제거
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segment.insertSegment(withTitle: "학교 게시판", at: 0, animated: true)
        segment.insertSegment(withTitle: "학군 게시판", at: 1, animated: true)
        segment.insertSegment(withTitle: "전국 게시판", at: 2, animated: true)
        
        segment.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: "gray"),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], for: .normal)
        
        // 선택 되었을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], for: .selected)
        
                segment.addTarget(self, action: #selector(changeSegmentedControl), for: .valueChanged)
        
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lineGray")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nothingLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 작성한 글이 없어요"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutoLayout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)
        view.addSubview(navigationBar)
        view.addSubview(containerView)
        containerView.addSubview(segmentControl)
        view.addSubview(lineView)
        view.addSubview(nothingLabel)
        
        
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            segmentControl.topAnchor.constraint(equalTo: containerView.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            segmentControl.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            segmentControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            lineView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            nothingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nothingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    
    @objc private func changeSegmentedControl(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // 학교 게시판
        }
        else if sender.selectedSegmentIndex == 1 {
            // 학군 게시판
        }
        else if sender.selectedSegmentIndex == 2 {
            // 전국 게시판
        }
    }
    
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
