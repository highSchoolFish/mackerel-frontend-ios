//
//  FindIDViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit
import SwiftUI

class FindIDViewController: UIViewController {
    var limitTime: Int = 120    // 2분
    
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
    
    private lazy var findIdLabel: UILabel = {
        var label = UILabel()
        label.text = "아이디 찾기"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "이름"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "본인 이름 입력"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.returnKeyType = .done
        tf.frame.size.height = 40
        tf.keyboardType = .default
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var phoneLabel: UILabel = {
        var label = UILabel()
        label.text = "휴대폰 인증"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "전화번호 입력 '-' 제외"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.returnKeyType = .done
        tf.keyboardType = .numberPad
        tf.frame.size.height = 40
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var sendCertifyNumberButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("인증번호 전송", for: .normal)
        button.backgroundColor = UIColor(named:"lightGray")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button.addTarget(self, action: #selector(sendCertifyNumberButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var certifyLabel: UILabel = {
        var label = UILabel()
        label.text = "인증번호"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var certificationTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "인증번호 입력"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.returnKeyType = .done
        tf.frame.size.height = 40
        tf.keyboardType = .numberPad
        tf.frame.size.height = 40
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var timeLabel: UILabel = {
        var label = UILabel()
        label.text = "02:00"
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = UIColor(named: "main")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var certificationButton: UIButton = {
        var button = UIButton()
        button.setTitle("인증하기", for: .normal)
        button.backgroundColor = UIColor(named:"lightGray")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button.addTarget(self, action: #selector(certificationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var label1: UILabel = {
        var label = UILabel()
        label.text = "* 회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야 인증번호를 받을 수 있습니다."
        label.font = UIFont.systemFont(ofSize: 8)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var findIdButton: UIButton = {
        var button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("아이디 찾기", for: .normal)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(findIdButtonTapped), for: .touchUpInside)
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
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(phoneLabel)
        view.addSubview(numberTextField)
        view.addSubview(sendCertifyNumberButton)
        view.addSubview(certifyLabel)
        view.addSubview(certificationTextField)
        view.addSubview(timeLabel)
        view.addSubview(certificationButton)
        view.addSubview(label1)
        view.addSubview(findIdButton)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            findIdLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            findIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            findIdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            findIdLabel.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nameLabel.topAnchor.constraint(equalTo: findIdLabel.bottomAnchor, constant: 30),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            phoneLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            numberTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            numberTextField.trailingAnchor.constraint(equalTo: sendCertifyNumberButton.leadingAnchor, constant: -4),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sendCertifyNumberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            sendCertifyNumberButton.centerYAnchor.constraint(equalTo: numberTextField.centerYAnchor, constant: 0),
            sendCertifyNumberButton.heightAnchor.constraint(equalToConstant: 40),
            sendCertifyNumberButton.widthAnchor.constraint(equalTo: certificationButton.widthAnchor),
            
            certifyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            certifyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            certifyLabel.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 24),
            
            certificationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            certificationTextField.topAnchor.constraint(equalTo: certifyLabel.bottomAnchor, constant: 8),
            certificationTextField.trailingAnchor.constraint(equalTo: certificationButton.leadingAnchor, constant: -4),
            certificationTextField.heightAnchor.constraint(equalToConstant: 40),
            
            timeLabel.trailingAnchor.constraint(equalTo: certificationTextField.trailingAnchor, constant: -5),
            timeLabel.centerYAnchor.constraint(equalTo: certificationTextField.centerYAnchor, constant: 0),
            
            certificationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            certificationButton.widthAnchor.constraint(equalToConstant: 60),
            certificationButton.centerYAnchor.constraint(equalTo: certificationTextField.centerYAnchor, constant: 0),
            certificationButton.heightAnchor.constraint(equalToConstant: 40),
            
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            label1.topAnchor.constraint(equalTo: certificationTextField.bottomAnchor, constant: 5),
            
            findIdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            findIdButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            findIdButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            findIdButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            findIdButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
    }
    
    @objc func sendCertifyNumberButtonTapped(button: UIButton) {
        // 인증번호 전송 버튼 누름
        timeLabel.isHidden = false
        FindViewModel.shared.sendCertifyNumberButtonTapped()
        sendCertifyNumberButton.backgroundColor = UIColor(named: "gray")
        certificationTextField.isEnabled = true
        certificationButton.isEnabled = true
        certificationButton.backgroundColor = UIColor(named: "main")
        findIdButton.isEnabled = false
        findIdButton.backgroundColor = UIColor(named: "gray")
        
        getSetTime()
    }
    
    @objc func certificationButtonTapped(button: UIButton) {
        // 인증번호 확인 버튼 누름
        FindViewModel.shared.confirmCertifyNumberButtonTapped()
        
        FindViewModel.shared.onCompleteCertification = { result in
            if result {
                // 인증 완료
                print("onCompleteCertification")
                self.timeLabel.isHidden = true
                self.numberTextField.isEnabled = false
                self.certificationTextField.isEnabled = false
                self.certificationButton.isEnabled = false
                self.certificationButton.backgroundColor = UIColor(named: "gray")
                self.findIdButton.isEnabled = true
                self.findIdButton.backgroundColor = UIColor(named: "main")
                
            }
            else {
                self.sendCertifyNumberButton.backgroundColor = UIColor(named: "gray")
                self.sendCertifyNumberButton.isEnabled = false
                
                self.certificationButton.backgroundColor = UIColor(named: "gray")
                self.certificationButton.isEnabled = false
            }
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField == self.nameTextField {
            FindViewModel.shared.setName(textField.text ?? "")
        }
        
        if textField == self.numberTextField {
            FindViewModel.shared.setPhoneNumber(textField.text ?? "")
            FindViewModel.shared.onPhoneNumberChecked = { result in
                if result {
                    // true 전화번호 11자리 ㅇ
                    if self.nameTextField.text!.count >= 2 {
                        self.sendCertifyNumberButton.isEnabled = true
                        self.sendCertifyNumberButton.backgroundColor = UIColor(named: "main")
                    }
                }
                else {
                    // false 전화번호 x
                    self.sendCertifyNumberButton.isEnabled = false
                    self.sendCertifyNumberButton.backgroundColor = UIColor(named: "gray")
                    self.certificationButton.backgroundColor = UIColor(named: "gray")
                    self.certificationTextField.isEnabled = false
                }
            }
        }
        
        if textField == self.certificationTextField {
            FindViewModel.shared.setCertifyNumber(textField.text ?? "")
            FindViewModel.shared.onCertifyNumberChecked  = { result in
                if result {
                    // true 인증번호 6자리 ㅇ
                    self.certificationButton.isEnabled = true
                    self.certificationButton.backgroundColor = UIColor(named: "main")
                }
                else {
                    // false 인증번호 x
                    self.certificationButton.isEnabled = false
                    self.certificationButton.backgroundColor = UIColor(named: "gray")
                }
            }
        }
        
    }
    
    @objc func getSetTime(){
        secToTime(sec: limitTime)
        limitTime -= 1
    }
    
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            timeLabel.text = String(minute) + ":" + "0" + String(second)
        }
        else {
            timeLabel.text = String(minute) + ":" + String(second)
        }
        
        if limitTime != 0 {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        }
        else if limitTime == 0 {
            // 시간 초기화
            timeLabel.text = "02:00"
            limitTime = 120
            
            // 인증번호 전송버튼 번호 확인 후 활성화
            if (FindViewModel.shared.onPhoneNumberChecked != nil) == true {
                sendCertifyNumberButton.isEnabled = true
                sendCertifyNumberButton.backgroundColor = UIColor(named: "main")
            }
            
            findIdButton.isEnabled = false
            findIdButton.backgroundColor = UIColor(named: "gray")
            
            // 인증하기 버튼, 인증번호 입력tf 초기화
            certificationTextField.text = ""
            certificationButton.isEnabled = false
            certificationButton.backgroundColor = UIColor(named: "gray")
        }
    }
    
    @objc private func findIdButtonTapped(_ button: UIButton) {
        print("findIdButtonTapped")
        print(FindViewModel.shared.nameString)
        print(FindViewModel.shared.phoneNumberString)
        print("test before button tapped")
        FindViewModel.shared.findIdButtonTapped()
        FindViewModel.shared.onFindIdComplete = { result in
            if result {
                print("result true")
                // 찾기 성공
                let nextVC = FindIDResultViewController()
                nextVC.modalPresentationStyle = .fullScreen
                self.present(nextVC, animated: true)
            }
            else {
                print("result false")

            }
        }
    }
    
    @objc private func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}




