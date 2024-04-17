//
//  FindIDResultViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit
import SwiftUI

class FindIDResultViewController: UIViewController {
    
    private lazy var findIdLabel: UILabel = {
        var label = UILabel()
        label.text = "아이디 찾기"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userInfoLabel: UILabel = {
        var label = UILabel()
        label.text = "회원정보"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var memberIdLabel: UILabel = {
        var label = UILabel()
        label.text = "∙ 아이디 : bhyn1234"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(named: "main")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createAtLabel: UILabel = {
        var label = UILabel()
        label.text = "가입 : 2023.01.07"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var resultView: UIView = {
        var view = UIView()
        view.addSubview(memberIdLabel)
        view.addSubview(createAtLabel)
        view.frame = CGRect(x: 0, y: 0, width: 260, height: 62)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named:"gray")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label1: UILabel = {
        var label = UILabel()
        label.text = "* 입력한 회원정보와 일치하는 아이디입니다."
        label.font = UIFont.systemFont(ofSize: 8)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        var button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(named: "main")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("로그인", for: .normal)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginButtonTapped)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var findPwButton: UIButton = {
        var button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(named:"main")?.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        button.setTitleColor(UIColor(named: "main"), for: .normal)
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.isEnabled = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(findPwButtonTapped)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupAutoLayout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(findIdLabel)
        view.addSubview(userInfoLabel)
        view.addSubview(resultView)
        view.addSubview(label1)
        view.addSubview(loginButton)
        view.addSubview(findPwButton)
        
        memberIdLabel.text = "∙ 아이디 : " + "\(FindViewModel.shared.resultIdString)"
        createAtLabel.text = "가입 : " + "\(FindViewModel.shared.resultCreateAtString)"
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            findIdLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            findIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            findIdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userInfoLabel.topAnchor.constraint(equalTo: findIdLabel.bottomAnchor, constant: 30),
            userInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            resultView.topAnchor.constraint(equalTo: userInfoLabel.bottomAnchor, constant: 8),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            resultView.heightAnchor.constraint(equalToConstant: 70),
            
            memberIdLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 17),
            memberIdLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 15),
            memberIdLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -15),
            memberIdLabel.heightAnchor.constraint(equalToConstant: 20),
            
            createAtLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 30),
            createAtLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -30),
            createAtLabel.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -15),
            createAtLabel.heightAnchor.constraint(equalToConstant: 15),
            
            label1.topAnchor.constraint(equalTo: resultView.bottomAnchor, constant: 8),
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            loginButton.bottomAnchor.constraint(equalTo: findPwButton.topAnchor, constant: -8),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            findPwButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            findPwButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            findPwButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            findPwButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func loginButtonTapped() {
        let nextVC = LoginViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc private func findPwButtonTapped() {
        let nextVC = FindPWViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
}
