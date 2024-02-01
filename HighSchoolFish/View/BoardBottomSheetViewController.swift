//
//  BoardBottomSheetViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/14/24.
//

import UIKit
import SwiftUI

class BoardBottomSheetViewController: UIViewController {
    private lazy var bottomSheetView: UIView = {
        let view = UIView()
        view.addSubview(bottomStackView)
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        var stView = UIStackView() 
        stView.addArrangedSubview(editButton)
        stView.addArrangedSubview(shareButton)
        stView.addArrangedSubview(deleteButton)
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.translatesAutoresizingMaskIntoConstraints = false
        return stView
    }()
    
    private lazy var editButton: UIButton = {
        var button = UIButton(type: .custom)
        button.titleLabel?.text = "수정하기"
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        var button = UIButton(type: .custom)
        button.titleLabel?.text = "공유하기"
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        var button = UIButton(type: .custom)
        button.titleLabel?.text = "삭제하기"
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bottomSheetView)
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetView.topAnchor.constraint(equalTo: view.topAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 150),
            
            bottomStackView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor),
            bottomStackView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
            
            editButton.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: 0),
            editButton.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: 0),
            shareButton.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: 0),
            shareButton.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: 0),
            deleteButton.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: 0),
            deleteButton.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: 0)
        ])
    }
    
    @objc private func editButtonTapped(){
        print("edit button tapped")
        
    }
}


struct PreView: PreviewProvider {
    static var previews: some View {
        BoardBottomSheetViewController().toPreview()
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

