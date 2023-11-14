//
//  AgreementViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/16.
//

import Foundation
import UIKit

final class AgreementViewController: UIViewController {
    
    private let viewModel = AgreementViewModel()

    private lazy var agreementLabel: UILabel = {
        var label = UILabel()
        label.text = "약관동의"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var acceptAllButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uncheckedRoundButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(acceptAllButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)
        return button
    }()
    
    private lazy var acceptAllLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전체 동의하기"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var allStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [acceptAllButton, acceptAllLabel])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.alignment = .fill
        stview.distribution = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "gray")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var acceptAgeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(acceptAgeButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)

        return button
    }()
    
    private lazy var acceptAgeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(필수) 만 14세 이상"
        label.textColor = UIColor(named: "gray")
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var detailAgeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("보기", for: .normal)
        button.setTitleColor(UIColor(named: "gray"), for: .normal)
        button.setUnderline()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var ageStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [acceptAgeButton, acceptAgeLabel, detailAgeButton])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.alignment = .center
        stview.distribution = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    private lazy var acceptInfoButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(acceptInfoButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)
        return button
    }()
    
    private lazy var acceptInfoLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(필수) 개인정보 처리방침 동의"
        label.textColor = UIColor(named: "gray")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var detailInfoButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("보기", for: .normal)
        button.setTitleColor(UIColor(named: "gray"), for: .normal)
        button.setUnderline()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [acceptInfoButton, acceptInfoLabel, detailInfoButton])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.alignment = .center
        stview.distribution = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    
    private lazy var acceptAdButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(acceptAdButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)

        return button
    }()
    
    private lazy var acceptAdLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(선택) 문자메세지 광고, 이벤트 수신"
        label.textColor = UIColor(named: "gray")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var adStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [acceptAdButton, acceptAdLabel])
        stview.spacing = 5
        stview.axis = .horizontal
        stview.alignment = .center
        stview.distribution = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    private lazy var boxView: UIView = {
        var view = UIView()
        [allStackView, lineView, ageStackView, infoStackView, adStackView].forEach { view.addSubview($0) }
        view.layer.borderColor = UIColor(named: "gray")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        var button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("다음", for: .normal)
        button.backgroundColor = UIColor(named: "gray")
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupAutoLayout()
        
        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        [agreementLabel, boxView, nextButton].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            agreementLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            agreementLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            agreementLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            boxView.topAnchor.constraint(equalTo: agreementLabel.bottomAnchor, constant: 30),
            boxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            boxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            boxView.bottomAnchor.constraint(equalTo: adStackView.bottomAnchor, constant: 16),

            allStackView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 16),
            allStackView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -16),
            allStackView.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 16),

            acceptAllButton.heightAnchor.constraint(equalToConstant: 30),
            acceptAgeButton.heightAnchor.constraint(equalToConstant: 30),
            acceptInfoButton.heightAnchor.constraint(equalToConstant: 30),
            acceptAdButton.heightAnchor.constraint(equalToConstant: 30),

            acceptAllButton.widthAnchor.constraint(equalTo: acceptAllButton.heightAnchor, multiplier: 1.0),
            acceptAgeButton.widthAnchor.constraint(equalTo: acceptAgeButton.heightAnchor, multiplier: 1.0),
            acceptInfoButton.widthAnchor.constraint(equalTo: acceptInfoButton.heightAnchor, multiplier: 1.0),
            acceptAdButton.widthAnchor.constraint(equalTo: acceptAdButton.heightAnchor, multiplier: 1.0),

            lineView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 13),
            lineView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -13),
            lineView.topAnchor.constraint(equalTo: allStackView.bottomAnchor, constant: 8),
            lineView.heightAnchor.constraint(equalToConstant: 1),

            ageStackView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 16),
            ageStackView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -16),
            ageStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 8),

            infoStackView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -16),
            infoStackView.topAnchor.constraint(equalTo: ageStackView.bottomAnchor, constant: 8),

            adStackView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 16),
            adStackView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -16),
            adStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 8),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func nextButtonTapped(button: UIButton){
        viewModel.nextButtonTapped(adNotifications: acceptAdButton.isSelected)
        
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true)
    }
    
    @objc func buttonIsSelected(button: UIButton){
        
        if acceptAdButton.isSelected == true {
            acceptAdButton.setImage(UIImage(named: "checkedButton"), for: .normal)
        }
        if acceptAgeButton.isSelected == true {
            acceptAgeButton.setImage(UIImage(named: "checkedButton"), for: .normal)
        }
        if acceptInfoButton.isSelected == true {
            acceptInfoButton.setImage(UIImage(named: "checkedButton"), for: .normal)
        }
        
        if acceptAdButton.isSelected == false {
            acceptAdButton.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        }
        if acceptAgeButton.isSelected == false {
            acceptAgeButton.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        }
        if acceptInfoButton.isSelected == false {
            acceptInfoButton.setImage(UIImage(named: "uncheckedButton"), for: .normal)
        }
        
        if acceptAgeButton.isSelected == true && acceptInfoButton.isSelected == true && acceptAdButton.isSelected == true {
            acceptAllButton.isSelected = true
        }
        
        if acceptAllButton.isSelected == true {
            acceptAllButton.setImage(UIImage(named: "checkedRoundButton"), for: .normal)
        }
        if acceptAllButton.isSelected == false {
            acceptAllButton.setImage(UIImage(named: "uncheckedRoundButton"), for: .normal)
        }
        
        if acceptInfoButton.isSelected == true && acceptAgeButton.isSelected == true {
            print("동의 완료")
            nextButton.backgroundColor = UIColor(named: "main")
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.isEnabled = true
        }
        else{
            print("동의 실패")
            nextButton.backgroundColor = UIColor(named: "gray")
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.isEnabled = false
        }
    }
    
    @objc func acceptAllButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            // true
            sender.isSelected = false
            acceptAdButton.isSelected = false
            acceptAgeButton.isSelected = false
            acceptInfoButton.isSelected = false
                        
            print("All Button tapped - \(sender.isSelected)")
            print("All Button tapped - \(sender.isSelected)")
            print("\(acceptAgeButton.isSelected) + \(acceptInfoButton.isSelected) + \(acceptAdButton.isSelected)")
            
        } else {
            // false
            sender.isSelected = true
            acceptAdButton.isSelected = true
            acceptAgeButton.isSelected = true
            acceptInfoButton.isSelected = true
            
            print("All Button tapped - \(sender.isSelected)")
            print("\(acceptAgeButton.isSelected) + \(acceptInfoButton.isSelected) + \(acceptAdButton.isSelected)")
        }
    }
    
    @objc func acceptInfoButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            acceptAllButton.isSelected = false
        } else {
            sender.isSelected = true
        }
        print("acceptInfoButtonTapped - \(sender.isSelected)")
        print("\(acceptAgeButton.isSelected) + \(acceptInfoButton.isSelected) + \(acceptAdButton.isSelected)")
    }
    
    @objc func acceptAgeButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            acceptAllButton.isSelected = false
        } else {
            sender.isSelected = true
        }
        print("acceptAgeButtonTapped - \(sender.isSelected)")
        print("\(acceptAgeButton.isSelected) + \(acceptInfoButton.isSelected) + \(acceptAdButton.isSelected)")
    }
    
    @objc func acceptAdButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            acceptAllButton.isSelected = false
        } else {
            sender.isSelected = true
        }
        print("acceptAdButtonTapped - \(sender.isSelected)")
        print("\(acceptAgeButton.isSelected) + \(acceptInfoButton.isSelected) + \(acceptAdButton.isSelected)")
    }
    
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension UIButton {
    func setUnderline() {
            guard let title = title(for: .normal) else { return }
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: title.count)
            )
            setAttributedTitle(attributedString, for: .normal)
    }
}
