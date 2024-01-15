//
//  TabBarViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/18.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
        
    private lazy var messageViewController: UIViewController = {
        let vc = MessageTabViewController()
        let tabBarItem = UITabBarItem(title: "메세지", image: UIImage(named: "messageTabIcon"), tag: 0)
        vc.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: vc)
        return navigationView
    }()
    
    private lazy var homeViewController: UIViewController = {
        let vc = HomeTabViewController()
        let tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeTabIcon"), tag: 1)
        vc.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: vc)
        return navigationView
    }()
    
    private lazy var myPageViewController: UIViewController = {
        let vc = MyPageTabViewController()
        let tabBarItem = UITabBarItem(title: "마이", image: UIImage(named: "myPageTabIcon"), tag: 2)
        vc.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: vc)
        return navigationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        viewControllers = [messageViewController, homeViewController, myPageViewController]
        self.setViewControllers(viewControllers, animated: true)
        configure()
        
        // 현재 자동로그인 하면 이 화면으로 오는데
        // 이후에 로그인 되었음을 알게해주는 keychain에 token이 왔는지 확인해야함
        // 만료되었으면 refresh 해줘야하고 --> 서버 통신할 때에 따로 해주면 될듯
        // 로그아웃 해서 다시 로그인 VC로 돌아가기 위한 버튼 추가해야할듯?
    }
    
    private func configure(){
        let tabBar: UITabBar = self.tabBar
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = UIColor(named: "lightGray")
        tabBar.layer.cornerRadius = 10
        tabBar.layer.masksToBounds = true
        tabBar.layer.backgroundColor = UIColor(named: "main")?.cgColor
        tabBar.barTintColor = UIColor(named: "main")
        tabBar.isTranslucent = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
}


