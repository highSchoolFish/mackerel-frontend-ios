//
//  RegisterUserInfoViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit

class RegisterUserInfoViewController: UIViewController {
    weak var delegate: IndexDelegate?
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        var tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.placeholder = "아이디 4~15자리 영문, 숫자 입력"
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
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var checkIdLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
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
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
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
        label.text = "비밀번호확인"
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
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
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
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nicknameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임 입력"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.layer.borderWidth = 1
        tf.returnKeyType = .done
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var checkNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("UserInfoViewDidLoad")        
        configure()
        setupAutoLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("UserInfoviewWillAppear")
        delegate?.indexUpdate(0)
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(idLabel)
        view.addSubview(idTextField)
        view.addSubview(checkIdLabel)
        view.addSubview(pwLabel)
        view.addSubview(pwTextField)
        view.addSubview(pw2Label)
        view.addSubview(pw2TextField)
        view.addSubview(checkPwLabel)
        view.addSubview(checkPw2Label)
        view.addSubview(passwordEyeButton)
        view.addSubview(password2EyeButton)
        view.addSubview(nicknameLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(checkNicknameLabel)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            idTextField.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 7),
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            idTextField.heightAnchor.constraint(equalToConstant: 40),
            
            checkIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            checkIdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            checkIdLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 2),
            
            pwLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pwLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pwLabel.topAnchor.constraint(equalTo: checkIdLabel.bottomAnchor, constant: 25),
            
            pwTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pwTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pwTextField.topAnchor.constraint(equalTo: pwLabel.bottomAnchor, constant: 7),
            pwTextField.heightAnchor.constraint(equalToConstant: 40),
            
            checkPwLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            checkPwLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            checkPwLabel.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 2),
            
            passwordEyeButton.trailingAnchor.constraint(equalTo: pwTextField.trailingAnchor, constant: -5),
            passwordEyeButton.centerYAnchor.constraint(equalTo: pwTextField.centerYAnchor, constant: 0),
            
            pw2Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pw2Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pw2Label.topAnchor.constraint(equalTo: checkPwLabel.bottomAnchor, constant: 25),
            
            pw2TextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pw2TextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pw2TextField.topAnchor.constraint(equalTo: pw2Label.bottomAnchor, constant: 7),
            pw2TextField.heightAnchor.constraint(equalToConstant: 40),
            
            checkPw2Label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            checkPw2Label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            checkPw2Label.topAnchor.constraint(equalTo: pw2TextField.bottomAnchor, constant: 2),
            
            password2EyeButton.trailingAnchor.constraint(equalTo: pw2TextField.trailingAnchor, constant: -5),
            password2EyeButton.centerYAnchor.constraint(equalTo: pw2TextField.centerYAnchor, constant: 0),
            
            nicknameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nicknameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nicknameLabel.topAnchor.constraint(equalTo: checkPw2Label.bottomAnchor, constant: 25),
            
            nicknameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nicknameTextField.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 7),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            checkNicknameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            checkNicknameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            checkNicknameLabel.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 2)
        ])
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
        // TF 편집 시 RegisterRegisterViewModel.shared.shared.set로 전달
        if textField == self.idTextField {
            RegisterViewModel.shared.setId(textField.text ?? "")
            RegisterViewModel.shared.onIdCheckResult = { checkIdString, idColor in
                self.checkIdLabel.text = checkIdString
                self.checkIdLabel.textColor = idColor
                if idColor == UIColor(named:"blue") {
                    RegisterViewModel.shared.setIsCheckedId(true)

                }
                else {
                    RegisterViewModel.shared.setIsCheckedId(false)
                }
            }
        }
        if textField == self.pwTextField {
            (checkPwLabel.text, checkPwLabel.textColor) = RegisterViewModel.shared.setPassword(textField.text ?? "")
        }
        if textField == self.pw2TextField {
            (checkPw2Label.text, checkPw2Label.textColor) = RegisterViewModel.shared.setPassword2(textField.text ?? "")
        }
        if textField == self.nicknameTextField {
            print("editing")

            RegisterViewModel.shared.setNickname(textField.text ?? "")
            RegisterViewModel.shared.onNicknameCheckResult = { checkNicknameString, nickColor in
                self.checkNicknameLabel.text = checkNicknameString
                self.checkNicknameLabel.textColor = nickColor
                if nickColor == UIColor(named: "blue") {
                    RegisterViewModel.shared.setIsCheckedNickname(true)
                }
                else {
                    RegisterViewModel.shared.setIsCheckedNickname(false)
                }
            }
        }
        
        if self.pwTextField.text?.count != 0 {
            if self.pwTextField.text == self.pw2TextField.text {
                RegisterViewModel.shared.setIsCheckedPw(true)
            }
            else {
                RegisterViewModel.shared.setIsCheckedPw(false)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
