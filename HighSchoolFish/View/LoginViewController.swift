//
//  ViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/16.
//

import UIKit
import SwiftUI

final class LoginViewController: UIViewController {
    var test = "test"
    var fCurTextfieldBottom: CGFloat = 0.0
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "고등어"
        label.textColor = UIColor(named:"main")
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        var tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = "아이디 입력"
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.layer.borderWidth = 1
        tf.autocapitalizationType = .none
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.keyboardType = .emailAddress
        tf.returnKeyType = .done
        tf.frame.size.height = 40
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        var tf = UITextField()
        tf.addSubview(passwordSecureButton)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.placeholder = "비밀번호 입력"
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
        tf.frame.size.height = 40
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var passwordSecureButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = UIColor(named: "lightGray")
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var autoLoginButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(autoLoginButtonTapped), for: .touchUpInside)
        button.frame.size.height = 10
        button.frame.size.width = 10
        
        return button
    }()
    
    private lazy var autoLoginLabel: UILabel = {
        var label = UILabel()
        label.text = "자동로그인"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = UIColor(named: "lightGray")
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [findIdButton, barView1, findPasswordButton, barView2, registerButton])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    private lazy var barView1: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var barView2: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var findIdButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("아이디 찾기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(findIdButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var findPasswordButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupAutoLayout()
        
        
    }
    
    // MARK: - configure
    private func configure() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        idTextField.delegate = self
        passwordTextField.delegate = self
        [titleLabel, idTextField, passwordTextField, autoLoginLabel, autoLoginButton, loginButton, stackView].forEach { view.addSubview($0) }
    }
    
    private func setupAutoLayout(){
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            idTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
            idTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -8),
            passwordSecureButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 0),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0),
            
            autoLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            autoLoginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            
            autoLoginLabel.leadingAnchor.constraint(equalTo: autoLoginButton.trailingAnchor, constant: 5),
            autoLoginLabel.centerYAnchor.constraint(equalTo: autoLoginButton.centerYAnchor),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.topAnchor.constraint(equalTo: autoLoginButton.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            findPasswordButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            findPasswordButton.widthAnchor.constraint(equalToConstant: 100),
            
            barView1.widthAnchor.constraint(equalToConstant: 1),
            barView1.heightAnchor.constraint(equalToConstant: 20),
            
            barView2.widthAnchor.constraint(equalToConstant: 1),
            barView2.heightAnchor.constraint(equalToConstant: 20),
            
            stackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
    }
    
    // MARK: - 로그인 버튼 눌림 ===> 뷰모델에 전달 ⭐️⭐️⭐️ (Input)
    @objc func loginButtonTapped() {
        LoginViewModel.shared.loginButtonTapped()
        LoginViewModel.shared.setAutoLoginBool(self.autoLoginButton.isSelected)
        handleLoginProcess()
    }
    
    @objc func autoLoginButtonTapped() {
        if autoLoginButton.isSelected {
            autoLoginButton.isSelected = false
            self.autoLoginButton.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        } else {
            autoLoginButton.isSelected = true
            self.autoLoginButton.setImage(UIImage(named: "checkedButton"), for: .selected)
        }
    }
    
    @objc func findIdButtonTapped() {
        let nextVC = FindIDViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc func findPasswordButtonTapped() {
        let nextVC = FindPWViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc func registerButtonTapped() {
        let nextVC = AgreementViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    // MARK: - 로그인 결과 처리 클로저 설정
    private func handleLoginProcess() {
        // 로그인 처리 결과에 따라서 처리할 로직 ⭐️⭐️⭐️
        LoginViewModel.shared.loginStatusChanged = { [unowned self] loginStatus in
            switch loginStatus {
            case .authenticated:
                goToNextVC()
                print("로그인 성공")
            case .loginDenied:
                print("로그인 실패")
            default:
                break
            }
        }
    }
    
    // MARK: - 화면이동
    private func goToNextVC() {
        print("tabVC open func")
        let nextVC = TabBarViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    // 화면 누르면 키보드 내려가게
    @objc func endEditing() {
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setKeyboardObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if fCurTextfieldBottom <= self.view.frame.height - keyboardSize.height {
                return
            }
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
        passwordSecureButton.isSelected.toggle()
        let eyeImage = passwordSecureButton.isSelected ? "eye" : "eye.slash"
        passwordSecureButton.setImage(UIImage(systemName: eyeImage), for: .normal)
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // tf 입력 시작되었을 때 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fCurTextfieldBottom = textField.frame.origin.y + textField.frame.height
    }
    
    
    
    
    
    
    @objc func textFieldEditingChanged(textField: UITextField){
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        // MARK: - 이메일주소 입력 ===> 뷰모델에 전달 ⭐️⭐️⭐️ (Input)
        if textField == idTextField {
            LoginViewModel.shared.setEmailText(textField.text ?? "")
        }
        
        // MARK: - 비밀번호 입력 ===> 뷰모델에 전달 ⭐️⭐️⭐️ (Input)
        if textField == passwordTextField {
            LoginViewModel.shared.setPasswordText(textField.text ?? "")
        }
        
        if (textField.text!.count > 15) {
            textField.deleteBackward()
        }
        
        // MARK: tf 편집시 빈칸확인
        guard
            let id = idTextField.text, !id.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else{
            loginButton.isEnabled = false
            print("[LoginVC] 빈칸 존재")
            return
        }
        
        loginButton.backgroundColor = UIColor(named: "main")
        loginButton.isEnabled = true
        print("[LoginVC] 로그인 버튼 활성화")
    }
}
