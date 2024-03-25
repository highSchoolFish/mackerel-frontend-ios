//
//  CustomAlertViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/7/24.
//

import UIKit
import SwiftUI

class CustomAlertViewController: UIViewController {

    private lazy var backView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.addSubview(titleLabel)
        view.addSubview(lineView)
        view.addSubview(contentLabel)
        view.addSubview(buttonStackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "titleLabel"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "red")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "gray")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentLabel: UILabel = {
        var label = UILabel()
        label.text = "contentLabel"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "blue")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var buttonStackView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(cancelButton)
        stView.addArrangedSubview(confirmButton)
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()

    private lazy var cancelButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(named: "lightGray")
        button.setTitleColor(UIColor(named: "darkGray"), for: .normal)
        button.setTitle("닫기", for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var confirmButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor(named: "main")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("확인", for: .normal)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(backView)
        setAutoLayout()
        
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            lineView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),

            contentLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            contentLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            contentLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),

            buttonStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 0),
            buttonStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 0),
            buttonStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }

    @objc func confirmButtonTapped() {
        print("confirmButtonTapped")
        let status = CustomAlertViewModel.shared.alertStatus
        CustomAlertViewModel.shared.confirmButtonTapped(checkStatus: status)
        
        // 버튼 누르면 상태 전달
        
        CustomAlertViewModel.shared.onConfirmComplete = { result in
            if result {
                // 버튼 눌리고 case 통과 완료하면
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @objc func cancelButtonTapped() {
        print("cancelButtonTapped")
        CustomAlertViewModel.shared.cancelButtonTapped()
        
        CustomAlertViewModel.shared.onCancelComplete = { result in
            if result {
                // 닫기 버튼
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func show(alertTitle: String, alertMessage: String, alertType: AlertType, on viewController: UIViewController) {
        // 제목과 내용 설정
        titleLabel.text = alertTitle
        contentLabel.text = alertMessage
        switch alertType {
        case .defaultAlert:
            self.cancelButton.isHidden = false
            self.confirmButton.isHidden = false
        case .onlyConfirm:
            self.cancelButton.isHidden = true
            self.confirmButton.isHidden = false
        }
        
        // 상황에 따라서 닫기 버튼 없애야함..
        
        // 애니메이션과 함께 모달 형태로 CustomAlertViewController 표시
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        viewController.present(self, animated: true, completion: nil)
    }
}
