//
//  RegisterViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit
import SwiftUI

protocol IndexDelegate: AnyObject {
    func indexUpdate(_ newValue: Int)
}

class RegisterViewController: UIViewController, IndexDelegate {
    
    var currentIndex = 0
    //    private let viewModel = RegisterViewModel()
    
    
    private lazy var navigationBar: UINavigationBar = {
        let naviBar = UINavigationBar()
        naviBar.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.backBarButtonItem = backButton
        naviBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviBar.shadowImage = UIImage()
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backButton")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        return naviBar
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(backAction))
        button.tag = 1
        
        return button
    }()
    
    private lazy var registerLabel: UILabel = {
        var label = UILabel()
        label.text = "회원가입"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        var button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("가입하기", for: .normal)
        button.isEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerButtonTapped)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.dataSource = self
        vc.view.backgroundColor = .white
        return vc
    }()
    
    lazy var pageControl: UIPageControl = {
        // Create a UIPageControl.
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY - 100, width: self.view.frame.maxX, height:50))
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = UIColor(named: "lightGray") // 페이지를 암시하는 동그란 점의 색상
        pageControl.currentPageIndicatorTintColor = UIColor(named: "main") // 현재 페이지를 암시하는 동그란 점 색상
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    lazy var userInfoVC: UIViewController = {
        let vc = RegisterUserInfoViewController()
        vc.delegate = self
        return vc
    }()
    
    lazy var schoolVC: UIViewController = {
        let vc = RegisterSchoolViewController()
        pageControl.currentPage = 1
        vc.delegate = self
        return vc
    }()
    
    lazy var authVC: UIViewController = {
        let vc = RegisterAuthenticationViewController()
        pageControl.currentPage = 2
        vc.delegate = self
        return vc
    }()
    
    lazy var viewsList: [UIViewController] = {
        return [userInfoVC, schoolVC, authVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("registerVC didLoad")
        
        configure()
        setupAutoLayout()
        
        RegisterViewModel.shared.observableResult.subscribe { [weak self] result in
            print("result bind", result)
            
            if result == true {
                self?.registerButton.backgroundColor = UIColor(named: "main")
                self?.registerButton.isEnabled = true
            }
            else {
                self?.registerButton.backgroundColor = UIColor(named: "gray")
                self?.registerButton.isEnabled = false
            }
        }
        
        let nextVC = LoginViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("RegisterViewDidDisappear")
    }
    
    private func configure() {
        self.navigationItem.leftBarButtonItem = self.backButton
        view.backgroundColor = .white
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(pageViewController)
        
        view.addSubview(pageViewController.view)
        view.addSubview(registerLabel)
        view.addSubview(registerButton)
        view.addSubview(navigationBar)
        view.addSubview(pageControl)
        pageViewController.setViewControllers([userInfoVC], direction: .forward, animated: true, completion: nil)
        pageViewController.dataSource = self
        pageViewController.didMove(toParent: self)
        
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            registerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            registerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            registerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            registerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            pageViewController.view.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 20),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            pageViewController.view.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    func indexUpdate(_ newValue: Int) {
        print(newValue)
        currentIndex = newValue
        pageControl.currentPage = currentIndex
    }
    
    @objc private func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func registerButtonTapped() {
        print("registerButton Tapped")
        RegisterViewModel.shared.registerButtonTapped()
        
        RegisterViewModel.shared.onRegisterComplete = { result in
            if result {
                let nextVC = LoginViewController()
                nextVC.modalPresentationStyle = .fullScreen
                self.present(nextVC, animated: true)
            }
        }
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension RegisterViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewsList.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        print("---")
        return viewsList[index - 1]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewsList.firstIndex(of: viewController), index < viewsList.count - 1 else {
            return nil
        }
        print("+++")
        
        return viewsList[index + 1]
    }
}


//struct PreView: PreviewProvider {
//    static var previews: some View {
//        RegisterViewController().toPreview()
//    }
//}
//
//#if DEBUG
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: UIViewController
//        
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//        
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//    
//    func toPreview() -> some View {
//        Group {
//            Preview(viewController: self)
//                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//                .previewDisplayName("iPhone 13 Pro Max")
//            
//            Preview(viewController: self)
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
//            
//            Preview(viewController: self)
//                .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
//                .previewDisplayName("xs 미리보기")
//        }
//        
//    }
//}
//#endif
