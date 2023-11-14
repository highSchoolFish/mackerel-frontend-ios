//
//  RegisterAuthenticationViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import UIKit

class RegisterAuthenticationViewController: UIViewController {
    weak var delegate: IndexDelegate?
    
    var limitTime: Int = 120    // 2분
    
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
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var sendAuthenticationButton: UIButton = {
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
        label.text = "* 본인 명의의 휴대폰 정보를 정확히 입력해 주시기 바랍니다."
        label.font = UIFont.systemFont(ofSize: 8)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var label2: UILabel = {
        var label = UILabel()
        label.text = "* 타인의 명의를 도용하여 부정인증을 시도한 경우, 관련 법령에 따라 처벌 (3년 이하의 징역 또는 1천만원 이하의 벌금)을 받을 수 있습니다."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "gray")
        label.font = UIFont.systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AuthenticationViewDidLoad")
        configure()
        setupAutoLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("AuthenticationviewWillAppear")
        delegate?.indexUpdate(2)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(phoneLabel)
        view.addSubview(numberTextField)
        view.addSubview(sendAuthenticationButton)
        view.addSubview(certifyLabel)
        view.addSubview(certificationTextField)
        view.addSubview(timeLabel)
        view.addSubview(certificationButton)
        view.addSubview(label1)
        view.addSubview(label2)
        
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            phoneLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            numberTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            numberTextField.trailingAnchor.constraint(equalTo: sendAuthenticationButton.leadingAnchor, constant: -4),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sendAuthenticationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            sendAuthenticationButton.centerYAnchor.constraint(equalTo: numberTextField.centerYAnchor, constant: 0),
            sendAuthenticationButton.heightAnchor.constraint(equalToConstant: 40),
            sendAuthenticationButton.widthAnchor.constraint(equalTo: certificationButton.widthAnchor),
            
            
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
            
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 5)
            
        ])
    }
    
    @objc func sendCertifyNumberButtonTapped(button: UIButton) {
        // 인증번호 전송 버튼 누름
        timeLabel.isHidden = false
        RegisterViewModel.shared.sendCertifyNumberButtonTapped()
        sendAuthenticationButton.backgroundColor = UIColor(named: "gray")
        certificationTextField.isEnabled = true
        certificationButton.isEnabled = true
        certificationButton.backgroundColor = UIColor(named: "main")
        
        getSetTime()
    }
    
    @objc func certificationButtonTapped(button: UIButton) {
        // 인증번호 확인 버튼 누름
        RegisterViewModel.shared.confirmCertifyNumberButtonTapped()
        
        RegisterViewModel.shared.onCompleteCertification = { result in
            if result {
                // 인증 완료
                self.timeLabel.isHidden = true
                self.numberTextField.isEnabled = false
                self.certificationTextField.isEnabled = false
                self.certificationButton.isEnabled = false
                self.certificationButton.backgroundColor = UIColor(named:
                                                                    "gray")
                RegisterViewModel.shared.setIsCertified(true)
            }
            else {
                self.sendAuthenticationButton.backgroundColor = UIColor(named: "gray")
                self.sendAuthenticationButton.isEnabled = false
                
                self.sendAuthenticationButton.backgroundColor = UIColor(named: "gray")
                self.sendAuthenticationButton.isEnabled = false
                RegisterViewModel.shared.setIsCertified(false)
            }
        }
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField == self.nameTextField {
            RegisterViewModel.shared.setUserName(textField.text ?? "")
            if textField.text?.count != 0 {
                RegisterViewModel.shared.setIsCheckedName(true)
            }
        }
        
        if textField == self.numberTextField {
            RegisterViewModel.shared.setPhoneNumber(textField.text ?? "")
            RegisterViewModel.shared.onPhoneNumberChecked = { result in
                if result {
                    // true 전화번호 11자리 ㅇ
                    if self.nameTextField.text!.count >= 2 {
                        self.sendAuthenticationButton.isEnabled = true
                        self.sendAuthenticationButton.backgroundColor = UIColor(named: "main")
                        RegisterViewModel.shared.setIsCheckedPhoneNumber(true)
                        
                    }
                }
                else {
                    // false 전화번호 x
                    self.sendAuthenticationButton.isEnabled = false
                    self.sendAuthenticationButton.backgroundColor = UIColor(named: "gray")
                    self.certificationButton.backgroundColor = UIColor(named: "gray")
                    self.certificationTextField.isEnabled = false
                    RegisterViewModel.shared.setIsCheckedPhoneNumber(false)
                }
            }
        }
        
        if textField == self.certificationTextField {
            RegisterViewModel.shared.setCertificationNumber(textField.text ?? "")
            RegisterViewModel.shared.onCertifyNumberChecked  = { result in
                if result {
                    // true 인증번호 6자리 ㅇ
                    self.certificationButton.isEnabled = true
                    self.certificationButton.backgroundColor = UIColor(named: "main")
                    RegisterViewModel.shared.setIsCertified(true)
                }
                else {
                    // false 인증번호 x
                    self.certificationButton.isEnabled = false
                    self.certificationButton.backgroundColor = UIColor(named: "gray")
                    RegisterViewModel.shared.setIsCertified(false)
                    
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
            if (RegisterViewModel.shared.onPhoneNumberChecked != nil) == true {
                sendAuthenticationButton.isEnabled = true
                sendAuthenticationButton.backgroundColor = UIColor(named: "main")
            }
            
            // 인증하기 버튼, 인증번호 입력tf 초기화
            certificationTextField.text = ""
            certificationButton.isEnabled = false
            certificationButton.backgroundColor = UIColor(named: "gray")
        }
    }
    
    @objc private func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

