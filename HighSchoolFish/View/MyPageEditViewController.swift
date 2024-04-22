//
//  MyPageEditViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/9/24.
//

import Foundation
import UIKit
import SwiftUI
import SafeAreaBrush

class MyPageEditViewController: UIViewController {
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
        label.text = "프로필 수정"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameEditLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "이름"
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.frame.size.height = 40
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var nicknameEditLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nicknameTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "닉네임"
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.frame.size.height = 40
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var editButton: UIButton = {
        var button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(named: "lightGray")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("수정하기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        view.addSubview(profileImageView)
        view.addSubview(nameEditLabel)
        view.addSubview(nameTextField)
        view.addSubview(nicknameEditLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(editButton)
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            profileImageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            
            nameEditLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameEditLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameEditLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.topAnchor.constraint(equalTo: nameEditLabel.bottomAnchor, constant: 8),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            nicknameEditLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            nicknameEditLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nicknameEditLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nicknameTextField.topAnchor.constraint(equalTo: nicknameEditLabel.bottomAnchor, constant: 8),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            
            editButton.heightAnchor.constraint(equalToConstant: 40),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            
        ])
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
