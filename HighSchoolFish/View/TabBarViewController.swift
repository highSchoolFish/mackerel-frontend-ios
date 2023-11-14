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


