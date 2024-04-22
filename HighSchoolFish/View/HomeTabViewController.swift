//
//  HomeTabViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/19.
//

import Foundation
import UIKit
import SwiftUI
import SafeAreaBrush

class HomeTabViewController: UIViewController {
    
    var viewArrayForShadow: [UIView] = []
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.addSubview(topView)
        view.addSubview(tableStackView)
        view.addSubview(tableImageStackView)
        view.addSubview(boardStackView)
        view.addSubview(articleImageView)
        view.addSubview(popularCommunityView)
        view.addSubview(ebsButtonView)
        view.addSubview(cardView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "고등어"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noticeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(noticeButtonTapped), for: .touchUpInside)
        
        button.frame.size.height = 15
        button.frame.size.width = 15
        return button
    }()
    
    private func addDimmingView() {
        dimmingView = UIView(frame: self.view.bounds)
        dimmingView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView?.isHidden = true
        view.addSubview(dimmingView!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDimmingViewTap))
        dimmingView?.addGestureRecognizer(tapGesture)
    }
    
    private lazy var topView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "main")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(noticeButton)
        return view
    }()
    
    private lazy var tableImageStackView: UIStackView = {
        var stView = UIStackView()
        stView.spacing = 10
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        stView.alignment = .fill
        stView.addArrangedSubview(mealImageView)
        stView.addArrangedSubview(timeImageView)
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var mealImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "homeTableViewImage")
        imageView.contentMode = .bottomRight
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var timeImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "homeTableViewImage")
        imageView.contentMode = .bottomRight
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableStackView: UIStackView = {
        var stView = UIStackView()
        stView.spacing = 10
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        stView.alignment = .fill
        stView.addArrangedSubview(mealView)
        stView.addArrangedSubview(timeView)
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var mealView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.addSubview(mealLabel)
        //        view.addSubview(mealTableView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mealLabel: UILabel = {
        var label = UILabel()
        label.text = "오늘의 급식표"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mealTableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .green
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var timeView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.addSubview(timeLabel)
        view.addSubview(timeTableView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        var label = UILabel()
        label.text = "오늘의 시간표"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var boardStackView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(mySchoolCommunityView)
        stView.addArrangedSubview(schoolDistrictCommunityView)
        stView.addArrangedSubview(nationwideCommunityView)
        stView.spacing = 10
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var mySchoolCommunityView: UIView = {
        var view = UIView()
        view.addSubview(mySchoolVerticalStackView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mySchoolCommunityViewTapped)) // UIImageView 클릭 제스쳐
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mySchoolTextImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "mySchoolText")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mySchoolContextLabel: UILabel = {
        var label = UILabel()
        label.text = "즐거움이 가득한 우리학교 \n우리학교 소식을 공유해요!"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mySchoolImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "mySchoolImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mySchoolHorizontalStackView: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [mySchoolTextImageView, mySchoolContextLabel])
        stView.axis = .horizontal
        stView.distribution = .fill
        stView.spacing = 6
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var mySchoolVerticalStackView: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [mySchoolHorizontalStackView, mySchoolImageView])
        stView.axis = .vertical
        stView.spacing = 6
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var schoolDistrictCommunityView: UIView = {
        var view = UIView()
        view.addSubview(schoolDistrictVerticalStackView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(schoolDistrictCommunityViewTapped)) // UIImageView 클릭 제스쳐
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var schoolDistrictTextImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "schoolDistrictText")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var schoolDistrictContextLabel: UILabel = {
        var label = UILabel()
        label.text = "새로운 만남, 즐거운 소통 \n우리학군 소식을 공유해요!"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var schoolDistrictImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "schoolDistrictImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var schoolDistrictHorizontalStackView: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [schoolDistrictTextImageView, schoolDistrictContextLabel])
        stView.axis = .horizontal
        stView.spacing = 6
        stView.distribution = .fill
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var schoolDistrictVerticalStackView: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [schoolDistrictHorizontalStackView, schoolDistrictImageView])
        stView.axis = .vertical
        stView.spacing = 6
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var nationwideCommunityView: UIView = {
        var view = UIView()
        view.addSubview(nationwideVerticalStackView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nationwideCommunityViewTapped)) // UIImageView 클릭 제스쳐
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nationwideTextImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "nationwideText")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nationwideContextLabel: UILabel = {
        var label = UILabel()
        label.text = "나만 모르고 지나쳤던 \n전국의 학교소식을 들어요!"
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nationwideImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "nationwideImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nationwideHorizontalStackView: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [nationwideTextImageView, nationwideContextLabel])
        stView.axis = .horizontal
        stView.spacing = 6
        stView.distribution = .fill
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var nationwideVerticalStackView: UIStackView = {
        var stView = UIStackView(arrangedSubviews: [nationwideHorizontalStackView, nationwideImageView])
        stView.axis = .vertical
        stView.spacing = 6
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var articleImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "articleMain")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var popularCommunityView: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.404, green: 0.608, blue: 1, alpha: 0.2).cgColor // 색깔
        view.layer.shadowColor = UIColor(red: 0.404, green: 0.608, blue: 1, alpha: 0.2).cgColor // 색깔
        view.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
        view.layer.shadowRadius = 2 // 반경
        view.layer.shadowOpacity = 1 // alpha값
        view.layer.masksToBounds = false
        view.addSubview(popularCommunityTopStackView)
        view.addSubview(popularCommunityTableView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var popularCommunityTopStackView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(popularCommunityLabel)
        stView.addArrangedSubview(moreCommunityButton)
        stView.axis = .horizontal
        stView.alignment = .fill
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var popularCommunityLabel: UILabel = {
        var label = UILabel()
        label.text = "실시간 인기 글"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moreCommunityButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("더보기 >", for: .normal)
        button.setTitleColor(UIColor(named: "gray"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var popularCommunityTableView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(popularContentView1)
        stView.addArrangedSubview(popularContentView2)
        stView.addArrangedSubview(popularContentView3)
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var popularContentView1: UIView = {
        var view = PopularTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var popularContentView2: UIView = {
        var view = PopularTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var popularContentView3: UIView = {
        var view = PopularTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ebsButtonView: UIView = {
        var view = UIView()
        view.addSubview(ebsButtonLabel)
        view.addSubview(rightArrowImageView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ebsButtonViewTapped)) // UIImageView 클릭 제스쳐
        view.addGestureRecognizer(tapGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ebsButtonLabel: UILabel = {
        var label = UILabel()
        label.text = "ebs 바로가기"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightArrowImageView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "goButton")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var cardView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "cardBackgroundColor")
        view.addSubview(cardImageView)
        view.addSubview(cardNameLabel)
        view.addSubview(cardGradeLabel)
        view.addSubview(cardSchoolNameLabel)
        view.addSubview(cardHandleView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cardHandleView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "cardHandleColor")
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cardImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "profileIcon")
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cardSchoolNameLabel: UILabel = {
        var label = UILabel()
        label.text = "부흥고등학교"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardGradeLabel: UILabel = {
        var label = UILabel()
        label.text = "3학년"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardNameLabel: UILabel = {
        var label = UILabel()
        label.text = "강보현"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let screenHeight = UIScreen.main.bounds.height
    var cardCloseConstraint: NSLayoutConstraint?
    var cardOpenConstraint: NSLayoutConstraint?
    private var noticeViewController = NoticeViewController()
    private var dimmingView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewArrayForShadow = [mealView, timeView, mySchoolCommunityView, schoolDistrictCommunityView, nationwideCommunityView, ebsButtonView]
        cardCloseConstraint = cardView.heightAnchor.constraint(equalToConstant: 60)
        cardOpenConstraint = cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        
        view.bringSubviewToFront(self.cardView)
        configure()
        cardClose()
        setupAutoLayout()
        setShadow()
        addDimmingView()
        
        
        
    }
    
    private func configure() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        fillSafeArea(position: .top, color: UIColor.clear, gradient: false)
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        mealTableView.dataSource = self
        mealTableView.delegate = self
        
        timeTableView.dataSource = self
        timeTableView.delegate = self
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(type(of: self).wasDragged(gestureRecognizer:)))
        cardView.addGestureRecognizer(gesture)
        
        setCardUI()
        
    }
    
    private func setShadow() {
        for v in viewArrayForShadow {
            print(v)
            //뷰 그림자
            v.clipsToBounds = true
            v.layer.cornerRadius = 10
            v.layer.borderWidth = 0.5
            v.layer.borderColor = UIColor(red: 0.404, green: 0.608, blue: 1, alpha: 0.2).cgColor // 색깔
            v.layer.shadowColor = UIColor(red: 0.404, green: 0.608, blue: 1, alpha: 0.2).cgColor // 색깔
            v.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
            v.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
            v.layer.shadowRadius = 2 // 반경
            v.layer.shadowOpacity = 1 // alpha값
            v.layer.masksToBounds = false
        }
    }
    
    private func setupAutoLayout(){
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1200),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -300),
            topView.heightAnchor.constraint(equalToConstant: 500),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -100),
            
            noticeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            noticeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 0),
            
            tableImageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableImageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableImageStackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -50),
            
            mealImageView.leadingAnchor.constraint(equalTo: tableImageStackView.leadingAnchor),
            mealImageView.bottomAnchor.constraint(equalTo: tableImageStackView.bottomAnchor),
            mealImageView.heightAnchor.constraint(equalTo: mealImageView.widthAnchor, multiplier: 1.0),
            
            timeImageView.trailingAnchor.constraint(equalTo: tableImageStackView.trailingAnchor),
            timeImageView.bottomAnchor.constraint(equalTo: tableImageStackView.bottomAnchor),
            timeImageView.heightAnchor.constraint(equalTo: timeImageView.widthAnchor, multiplier: 1.0),
            
            tableStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableStackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -50),
            
            mealView.leadingAnchor.constraint(equalTo: tableStackView.leadingAnchor),
            mealView.heightAnchor.constraint(equalTo: mealView.widthAnchor, multiplier: 1.0),
            
            timeView.trailingAnchor.constraint(equalTo: tableStackView.trailingAnchor),
            timeView.heightAnchor.constraint(equalTo: timeView.widthAnchor, multiplier: 1.0),
            
            mealLabel.leadingAnchor.constraint(equalTo: mealView.leadingAnchor, constant: 5),
            mealLabel.topAnchor.constraint(equalTo: mealView.topAnchor, constant: 5),
            
            timeLabel.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 5),
            timeLabel.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 5),
            
            boardStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            boardStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            boardStackView.topAnchor.constraint(equalTo: tableStackView.bottomAnchor, constant: 10),
            
            mySchoolHorizontalStackView.leadingAnchor.constraint(equalTo: mySchoolCommunityView.leadingAnchor, constant: 10),
            mySchoolHorizontalStackView.trailingAnchor.constraint(equalTo: mySchoolCommunityView.trailingAnchor, constant: -10),
            mySchoolVerticalStackView.bottomAnchor.constraint(equalTo: mySchoolCommunityView.bottomAnchor, constant: -10),
            mySchoolVerticalStackView.topAnchor.constraint(equalTo: mySchoolCommunityView.topAnchor, constant: 10),
            
            mySchoolImageView.leadingAnchor.constraint(equalTo: mySchoolCommunityView.leadingAnchor, constant: 10),
            mySchoolImageView.trailingAnchor.constraint(equalTo: mySchoolCommunityView.trailingAnchor, constant: -10),
            
            mySchoolCommunityView.heightAnchor.constraint(equalTo: mySchoolCommunityView.widthAnchor, multiplier: 1.0),
            
            schoolDistrictHorizontalStackView.leadingAnchor.constraint(equalTo: schoolDistrictCommunityView.leadingAnchor, constant: 10),
            schoolDistrictHorizontalStackView.trailingAnchor.constraint(equalTo: schoolDistrictCommunityView.trailingAnchor, constant: -10),
            schoolDistrictVerticalStackView.bottomAnchor.constraint(equalTo: schoolDistrictCommunityView.bottomAnchor, constant: -10),
            schoolDistrictVerticalStackView.topAnchor.constraint(equalTo: schoolDistrictCommunityView.topAnchor, constant: 10),
            schoolDistrictImageView.leadingAnchor.constraint(equalTo: schoolDistrictCommunityView.leadingAnchor, constant: 10),
            schoolDistrictImageView.trailingAnchor.constraint(equalTo: schoolDistrictCommunityView.trailingAnchor, constant: -10),
            
            schoolDistrictCommunityView.heightAnchor.constraint(equalTo: schoolDistrictCommunityView.widthAnchor, multiplier: 1.0),
            
            nationwideHorizontalStackView.leadingAnchor.constraint(equalTo: nationwideCommunityView.leadingAnchor, constant: 10),
            nationwideHorizontalStackView.trailingAnchor.constraint(equalTo: nationwideCommunityView.trailingAnchor, constant: -10),
            nationwideVerticalStackView.bottomAnchor.constraint(equalTo: nationwideCommunityView.bottomAnchor, constant: -10),
            nationwideVerticalStackView.topAnchor.constraint(equalTo: nationwideCommunityView.topAnchor, constant: 10),
            nationwideImageView.leadingAnchor.constraint(equalTo: nationwideCommunityView.leadingAnchor, constant: 10),
            nationwideImageView.trailingAnchor.constraint(equalTo: nationwideCommunityView.trailingAnchor, constant: -10),
            nationwideCommunityView.heightAnchor.constraint(equalTo: nationwideCommunityView.widthAnchor, multiplier: 1.0),
            
            articleImageView.topAnchor.constraint(equalTo: boardStackView.bottomAnchor, constant: 10),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            articleImageView.heightAnchor.constraint(equalToConstant: 100),
            
            popularCommunityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            popularCommunityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            popularCommunityView.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            popularCommunityView.heightAnchor.constraint(equalTo: popularCommunityView.widthAnchor, multiplier: 1.0),
            
            popularCommunityTopStackView.leadingAnchor.constraint(equalTo: popularCommunityView.leadingAnchor, constant: 8),
            popularCommunityTopStackView.trailingAnchor.constraint(equalTo: popularCommunityView.trailingAnchor, constant: -8),
            popularCommunityTopStackView.topAnchor.constraint(equalTo: popularCommunityView.topAnchor, constant: 15),
            popularCommunityTopStackView.heightAnchor.constraint(equalToConstant: 50),
            
            moreCommunityButton.trailingAnchor.constraint(equalTo: popularCommunityTopStackView.trailingAnchor),
            
            popularCommunityTableView.leadingAnchor.constraint(equalTo: popularCommunityView.leadingAnchor, constant: 8),
            popularCommunityTableView.trailingAnchor.constraint(equalTo: popularCommunityView.trailingAnchor, constant: -8),
            popularCommunityTableView.topAnchor.constraint(equalTo: popularCommunityTopStackView.bottomAnchor, constant: 10),
            popularCommunityTableView.bottomAnchor.constraint(equalTo: popularCommunityView.bottomAnchor, constant: -10),
            
            ebsButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ebsButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ebsButtonView.topAnchor.constraint(equalTo: popularCommunityView.bottomAnchor, constant: 12),
            ebsButtonView.heightAnchor.constraint(equalToConstant: 80),
            
            ebsButtonLabel.centerXAnchor.constraint(equalTo: ebsButtonView.centerXAnchor, constant: 0),
            ebsButtonLabel.centerYAnchor.constraint(equalTo: ebsButtonView.centerYAnchor, constant: 0),
            
            rightArrowImageView.leadingAnchor.constraint(equalTo: ebsButtonLabel.trailingAnchor, constant: 20),
            rightArrowImageView.centerYAnchor.constraint(equalTo: ebsButtonView.centerYAnchor, constant: 0),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            cardHandleView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            cardHandleView.heightAnchor.constraint(equalToConstant: 10),
            cardHandleView.widthAnchor.constraint(equalToConstant: 100),
            cardHandleView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor, constant: 0),
            
            cardNameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -50),
            cardNameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            cardGradeLabel.bottomAnchor.constraint(equalTo: cardNameLabel.topAnchor, constant: -20),
            cardGradeLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            cardSchoolNameLabel.bottomAnchor.constraint(equalTo: cardGradeLabel.topAnchor, constant: -50),
            cardSchoolNameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            cardImageView.bottomAnchor.constraint(equalTo: cardSchoolNameLabel.topAnchor, constant: -80),
            cardImageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            cardImageView.widthAnchor.constraint(equalToConstant: 150),
            cardImageView.heightAnchor.constraint(equalTo: cardImageView.widthAnchor, multiplier: 1.0)
            
            
        ])
    }
    
    private func setCardUI() {
        let userName = MemberInfoViewModel.shared.userNameString
        let userProfile = MemberInfoViewModel.shared.userProfileString
        let userGrade = MemberInfoViewModel.shared.userGradeString
        let userNickname = MemberInfoViewModel.shared.userNicknameString
        let userSchoolName = MemberInfoViewModel.shared.userSchoolNameString
        
        self.cardNameLabel.text = userName
        
        if userProfile == "" {
            self.cardImageView.image = UIImage(named: "profileIcon")
        }
        else {
            // userProfile 기본 아닌 경우
        }
        
        if userGrade == "HIGH_FIRST" {
            self.cardGradeLabel.text = "1학년"
        }else if userGrade == "HIGH_SECOND" {
            self.cardGradeLabel.text = "2학년"
        }else if userGrade == "HIGH_THIRD" {
            self.cardGradeLabel.text = "3학년"
        }
        
        self.cardSchoolNameLabel.text = userSchoolName
    }
    
    private func cardClose() {
        DispatchQueue.global().sync {
            
            self.cardImageView.isHidden = true
            self.cardSchoolNameLabel.isHidden = true
            self.cardGradeLabel.isHidden = true
            self.cardNameLabel.isHidden = true
            
                print("hidden ==================")
        }
        cardOpenConstraint?.isActive = false
        cardCloseConstraint?.isActive = true
    }
    
    private func cardOpen() {
        DispatchQueue.global().sync {
            
            cardCloseConstraint?.isActive = false
            cardOpenConstraint?.isActive = true
                print("constraint ==================")
        }
        
        self.cardImageView.isHidden = false
        self.cardSchoolNameLabel.isHidden = false
        self.cardGradeLabel.isHidden = false
        self.cardNameLabel.isHidden = false
        
    }
    
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let distanceFromBottom = screenHeight - gestureRecognizer.view!.center.y
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            print("changing state")
            // open, 제스처 방향 위로 할때
            //            cardOpenConstraint?.isActive = false
            // close, 제스처 아래로
            //            cardCloseConstraint?.isActive = false
            
            let translation = gestureRecognizer.translation(in: self.view)
            
            
            print("distanceFromBottom , \(distanceFromBottom)")
            print("translation.y , \(translation.y)")
            print(" test ", distanceFromBottom - translation.y)
            
            if((distanceFromBottom - translation.y) < 100) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
                gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            }
            
        }
        if gestureRecognizer.state == UIGestureRecognizer.State.ended{
            print("ending state")
            let velocity = gestureRecognizer.velocity(in: self.view)
            
            // 상하
            if abs(velocity.y) > abs(velocity.x) {
                if velocity.y > 0 {
                    print("down")
                    cardClose()
                    UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
                    }
                }
                else if velocity.y < 0 {
                    print("up")
                    cardOpen()
                    UIView.animate(withDuration: 0.2) {
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    }

    @objc private func handleDimmingViewTap() {
        let noticeVC = self.noticeViewController
        
        UIView.animate(withDuration: 0.3, animations: {
            // 사이드 메뉴를 원래 위치로 되돌림.
            noticeVC.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            // 어두운 배경 뷰를 숨김.
            self.dimmingView?.alpha = 0
        }) { (finished) in
            // 애니메이션이 완료된 후 사이드 메뉴를 뷰 계층 구조에서 제거.
            noticeVC.view.removeFromSuperview()
            noticeVC.removeFromParent()
            self.dimmingView?.isHidden = true
        }
    }
    
    @objc func noticeButtonTapped(_ sender: UIButton) {
        let noticeVC = self.noticeViewController
        self.addChild(noticeVC)
        self.view.addSubview(noticeVC.view)
        
        let menuWidth = self.view.frame.width * 0.8
        let menuHeight = self.view.frame.height
        
        let yPos = (self.view.frame.height / 2) - (menuHeight / 2)// 중앙에 위치하도록 yPos 계산
        
        
        // 사이드 메뉴의 시작 위치를 화면 왼쪽 바깥으로 설정.
        noticeVC.view.frame = CGRect(x: menuWidth, y: yPos, width: menuWidth, height: menuHeight)
        
        // 어두운 배경 뷰를 보이게 합니다.
        self.dimmingView?.isHidden = false
        self.dimmingView?.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            // 사이드 메뉴를 화면에 표시.
            noticeVC.view.frame = CGRect(x: 80, y: yPos, width: menuWidth, height: menuHeight)
            // 어두운 배경 뷰의 투명도를 조절.
            self.dimmingView?.alpha = 0.5
        })
    }
    
    @objc func mySchoolCommunityViewTapped(_ sender: UITapGestureRecognizer) {
        print("tapped my school community view")
        CommunityViewModel.shared.setCommunityNameString("schools")
        let vc = MySchoolCommunityViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func schoolDistrictCommunityViewTapped(sender: UITapGestureRecognizer) {
        CommunityViewModel.shared.setCommunityNameString("district")
        let vc = SchoolDistrictCommunityViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func nationwideCommunityViewTapped(sender: UITapGestureRecognizer) {
        //        CommunityViewModel.shared.setCommunityNameString("nationWide")
        let vc = NationwideCommunityViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func ebsButtonViewTapped(sender: UITapGestureRecognizer) {
        //        let vc = NationwideCommunityViewController()
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: true)
    }
}

extension HomeTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.timeTableView {
            return 7
        }
        if tableView == self.mealTableView {
            return 7
            
        }
        return 7
    }
    
}
