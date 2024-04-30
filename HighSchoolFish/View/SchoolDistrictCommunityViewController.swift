//
//  SchoolDistrictCommunityViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/09/19.
//

import Foundation
import UIKit

class SchoolDistrictCommunityViewController: UIViewController {
    private lazy var navigationBar: UINavigationBar = {
        let naviBar = UINavigationBar()
        naviBar.translatesAutoresizingMaskIntoConstraints = false
        naviBar.tintColor = .white
        naviBar.backgroundColor = UIColor(named:"main")
        naviBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviBar.shadowImage = UIImage()
        let naviTitleItem = UINavigationItem(title: "")
        let customBarButtonItem = UIBarButtonItem(customView: naviTitleLabel)

        naviTitleItem.leftBarButtonItems = [backButton, customBarButtonItem]
        naviTitleItem.rightBarButtonItems = [menuButton, findButton]

        naviBar.items = [naviTitleItem]
        return naviBar
    }()
    
    private lazy var naviTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "자신 학군 넣기"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let backImage = UIImage(named: "backButton")!
        let button = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        return button
    }()
    
    private lazy var findButton: UIBarButtonItem = {
        let findImage  = UIImage(named: "findIcon")!
        let button = UIBarButtonItem(image: findImage,  style: .plain, target: self, action: #selector(findButtonTapped))
        return button
    }()
        
    private lazy var menuButton: UIBarButtonItem = {
        let menuImage  = UIImage(named: "menuIcon")!
        let button = UIBarButtonItem(image: menuImage,  style: .plain, target: self, action: #selector(menuButtonTapped))
        return button
    }()
    
    private lazy var topView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.addSubview(titleLabelImage)
        view.addSubview(subTitleLabel)
        view.addSubview(topImageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabelImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "schoolDistrictText")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var subTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "새로운 만남, 즐거운 소통 \n우리학군 소식을 공유해요!"
        label.numberOfLines = 2
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "schoolDistrictImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var categoryView: UIView = {
        var view = CategoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var popularCommunityView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupAutoLayout()
        setShadow()
        CommunityViewModel.shared.setCommunityNameString("school_district")
        handleCategoryPresent()
    }
    
    private func configure() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        fillSafeArea(position: .top, color: UIColor(named: "main")!, gradient: false)

        view.addSubview(navigationBar)
        view.addSubview(topView)
        view.addSubview(categoryView)
        view.addSubview(popularCommunityView)
        
    }
    
    private func setShadow() {
        let viewArrayForShadow = [topView, popularCommunityView]
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
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            topView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabelImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 12),
            titleLabelImage.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            titleLabelImage.heightAnchor.constraint(equalToConstant: 50),
            titleLabelImage.widthAnchor.constraint(equalToConstant: 80),

            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabelImage.trailingAnchor, constant: 10),
            subTitleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 15),
            
            topImageView.leadingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor, constant: 10),
            topImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            topImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 0),

            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoryView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            
            popularCommunityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popularCommunityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            popularCommunityView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 20),
            popularCommunityView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            popularCommunityTopStackView.leadingAnchor.constraint(equalTo: popularCommunityView.leadingAnchor, constant: 8),
            popularCommunityTopStackView.trailingAnchor.constraint(equalTo: popularCommunityView.trailingAnchor, constant: -8),
            popularCommunityTopStackView.topAnchor.constraint(equalTo: popularCommunityView.topAnchor, constant: 15),
            popularCommunityTopStackView.heightAnchor.constraint(equalToConstant: 50),
            
            moreCommunityButton.trailingAnchor.constraint(equalTo: popularCommunityTopStackView.trailingAnchor, constant: 0),
            
            popularCommunityTableView.leadingAnchor.constraint(equalTo: popularCommunityView.leadingAnchor, constant: 8),
            popularCommunityTableView.trailingAnchor.constraint(equalTo: popularCommunityView.trailingAnchor, constant: -8),
            popularCommunityTableView.topAnchor.constraint(equalTo: popularCommunityTopStackView.bottomAnchor, constant: 10),
            popularCommunityTableView.bottomAnchor.constraint(equalTo: popularCommunityView.bottomAnchor, constant: -10)
            
        ])
    }
    
    @objc private func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func findButtonTapped(_ sender: Any) {
        
    }
    
    @objc private func menuButtonTapped(_ sender: Any) {
        
    }
    
    private func handleCategoryPresent() {
        CategoryViewModel.shared.categoryNameChanged = { [unowned self]
            categoryName in switch categoryName {
            case .free:
                   print("categoryName: free")
                CommunityViewModel.shared.setCategoryNameString("자유")
                let vc = CommunityViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            case .academy:
                   print("categoryName: academy")
                CommunityViewModel.shared.setCategoryNameString("학원")
                let vc = CommunityViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            case .university:
                   print("categoryName: university")
                CommunityViewModel.shared.setCategoryNameString("대학")
                let vc = CommunityViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            case .secret:
                   print("categoryName: secret")
                CommunityViewModel.shared.setCategoryNameString("비밀")
                let vc = CommunityViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            case .heart:
                   print("categoryName: heart")
                CommunityViewModel.shared.setCategoryNameString("연애")
                let vc = CommunityViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            default:
                break
            }
        }
    }
}
