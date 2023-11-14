//
//  ChangePWViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit
import SwiftUI

class ChangePWViewController: UIViewController {

    private var isTokenExpire : Bool = true
    
    private lazy var changePwLabel: UILabel = {
        var label = UILabel()
        label.text = "비밀번호 변경"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pwLabel: UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pwTextField: UITextField = {
        var tf = UITextField()
        tf.addSubview(passwordEyeButton)
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.placeholder = "비밀번호 8~15자의 영문,숫자, 특수문자(필수) 입력"
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var passwordEyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = UIColor(named: "lightGray")
//        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var checkPwLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pw2Label: UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호 확인"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pw2TextField: UITextField = {
        let tf = UITextField()
        
        tf.addSubview(password2EyeButton)
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.placeholder = "비밀번호 확인"
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
//        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var password2EyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = UIColor(named: "lightGray")
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var checkPw2Label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var label: UILabel = {
        var label = UILabel()
        label.text = "* 영문, 숫자 특수문자를 함께사용하면 (6자리 이상 16자리 이하) 보다 안전하게 사용할 수 있습니다."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "gray")
        label.font = UIFont.systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pwChangebutton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("비밀번호 변경", for: .normal)
        button.backgroundColor = UIColor(named: "lightGray")
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pwChangeButtonTapped)))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupAutoLayout()
        
        tokenTimeLimit()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(changePwLabel)
        view.addSubview(pwLabel)
        view.addSubview(pwTextField)
        view.addSubview(passwordEyeButton)
        view.addSubview(checkPwLabel)
        view.addSubview(pw2Label)
        view.addSubview(pw2TextField)
        view.addSubview(password2EyeButton)
        view.addSubview(checkPw2Label)
        view.addSubview(label)
        view.addSubview(pwChangebutton)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            changePwLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            changePwLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            changePwLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            changePwLabel.heightAnchor.constraint(equalToConstant: 20),
            
            pwLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pwLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pwLabel.topAnchor.constraint(equalTo: changePwLabel.bottomAnchor, constant: 30),
            
            pwTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pwTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pwTextField.topAnchor.constraint(equalTo: pwLabel.bottomAnchor, constant: 8),
            pwTextField.heightAnchor.constraint(equalToConstant: 40),

            
            checkPwLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            checkPwLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            checkPwLabel.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 30),
            
            passwordEyeButton.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor, constant: -5),
            passwordEyeButton.centerYAnchor.constraint(equalTo: pwTextField.centerYAnchor, constant: 0),
            
            pw2Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pw2Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pw2Label.topAnchor.constraint(equalTo: checkPwLabel.bottomAnchor, constant: 15),
            
            pw2TextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pw2TextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pw2TextField.topAnchor.constraint(equalTo: pw2Label.bottomAnchor, constant: 7),
            pw2TextField.heightAnchor.constraint(equalToConstant: 40),
            
            checkPw2Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            checkPw2Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            checkPw2Label.topAnchor.constraint(equalTo: pw2TextField.bottomAnchor, constant: 2),
            
            password2EyeButton.trailingAnchor.constraint(equalTo: pw2TextField.trailingAnchor, constant: -5),
            password2EyeButton.centerYAnchor.constraint(equalTo: pw2TextField.centerYAnchor, constant: 0),
            
            label.topAnchor.constraint(equalTo: checkPw2Label.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            pwChangebutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pwChangebutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pwChangebutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pwChangebutton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            pwChangebutton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func tokenTimeLimit() {
        print(FindViewModel.shared.expireIn)
        var limitTime = FindViewModel.shared.expireIn
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            print(limitTime)
            //남은 시간(초)에서 1초 더해야할거같음 왜냐 -299 시작인듯
            limitTime += 1
           
            //남은 시간(초)가 0보다 크면
            if limitTime == 0 {
                self.pwChangebutton.isEnabled = false
                self.pwChangebutton.backgroundColor = UIColor(named: "gray")
                self.isTokenExpire = true
            }
            else {
                self.isTokenExpire = false
            }
        })
    }
    
    @objc func passwordSecureModeSetting(_ sender: UIButton) {
        if sender == passwordEyeButton {
            passwordEyeButton.isSelected.toggle()
            pwTextField.isSecureTextEntry.toggle()
            let eyeImage = passwordEyeButton.isSelected ? "eye" : "eye.slash"
            passwordEyeButton.setImage(UIImage(systemName: eyeImage), for: .normal)
        }
        if sender == password2EyeButton {
            password2EyeButton.isSelected.toggle()
            pw2TextField.isSecureTextEntry.toggle()
            let eyeImage = password2EyeButton.isSelected ? "eye" : "eye.slash"
            password2EyeButton.setImage(UIImage(systemName: eyeImage), for: .normal)
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField == self.pwTextField {
            (checkPwLabel.text, checkPwLabel.textColor) = FindViewModel.shared.setPassword(textField.text ?? "")
        }
        if textField == self.pw2TextField {
            (checkPw2Label.text, checkPw2Label.textColor) = FindViewModel.shared.setPassword2(textField.text ?? "")
        }
        
        if self.pwTextField.text?.count != 0 {
            if self.pwTextField.text == self.pw2TextField.text {
                FindViewModel.shared.setIsCheckedPw(true)
            }
            else {
                FindViewModel.shared.setIsCheckedPw(false)
            }
        }
        
    }
    
    @objc func pwChangeButtonTapped(_ button: UIButton) {
        print("isTokenExpire ", isTokenExpire)
        if isTokenExpire {
            // 토큰 만료
            // alert 띄우기?
        }
        else {
            // 토큰 유효
            FindViewModel.shared.pwChangeButtonTapped()
        }
        
        FindViewModel.shared.onCompleteChangePw = { result in
            if result {
                // 변경완료시 로그인 화면 ㄱㄱ
                // alert로 확인 해줘야하나?
                let nextVC = LoginViewController()
                nextVC.modalPresentationStyle = .fullScreen
                self.present(nextVC, animated: true)
            }
            else {
                // 변경 실패
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
