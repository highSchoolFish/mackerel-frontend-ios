//
//  NoticeViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/8/24.
//

import UIKit
import SwiftUI

class NoticeViewController: UIViewController {
    
    private lazy var topView: UIView = {
        var view = UIView()
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "알림함"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "main")
        view.alpha = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var noticeTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var noticeEmptyLabel: UILabel = {
        var label = UILabel()
        label.text = "알림이 없습니다"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(named: "gray")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var noticeData: [Notice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        view.addSubview(topView)
        view.addSubview(lineView)
        view.addSubview(noticeTableView)
        view.addSubview(noticeEmptyLabel)
        setAutoLayout()
        
        if noticeData.count == 0 {
            // 알림 없음 label 보임
            noticeTableView.isHidden = true
            noticeEmptyLabel.isHidden = false


        }
        else {
            // tableView 보임
            noticeEmptyLabel.isHidden = true
            noticeTableView.isHidden = false

        }
        
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 10),
            
            backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            backButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor, multiplier: 1.0),
            
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor, constant: 0),            titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 10),
            
            lineView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            lineView.heightAnchor.constraint(equalToConstant: 5),
            
            noticeTableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 0),
            noticeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noticeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            noticeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            noticeEmptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            noticeEmptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}




struct PreView: PreviewProvider {
    static var previews: some View {
        NoticeViewController().toPreview()
    }
}

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Group {
            Preview(viewController: self)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")
            
            Preview(viewController: self)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
            
            Preview(viewController: self)
                .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
                .previewDisplayName("xs 미리보기")
        }
        
    }
}
#endif

