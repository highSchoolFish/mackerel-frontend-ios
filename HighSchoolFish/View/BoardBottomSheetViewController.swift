//
//  BoardBottomSheetViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/14/24.
//

import UIKit
import SwiftUI

class BoardBottomSheetViewController: UIViewController {
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomSheetView: UIView = {
        let view = UIView()
        view.addSubview(bottomStackView)
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        var stView = UIStackView()
        stView.addArrangedSubview(editButton)
        stView.addArrangedSubview(shareButton)
        stView.addArrangedSubview(deleteButton)
        stView.axis = .horizontal
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.distribution = .fillEqually
        return stView
    }()
    
    private lazy var editButton: UIButton = {
        var button = UIButton(type: .custom)
        button.titleLabel?.text = "수정하기"
        button.setTitleColor(.blue, for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
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
    
    var defaultHeight: CGFloat = 150
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height

        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        setAutoLayout()
        
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
            dimmedView.addGestureRecognizer(dimmedTap)
            dimmedView.isUserInteractionEnabled = true


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint,
            
            bottomStackView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor),
            bottomStackView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor)
            
        ])
    }
    
    @objc private func editButtonTapped(){
        print("edit button tapped")
        
    }
    
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                    // 4 - 1
            self.dimmedView.alpha = 0.7
                    // 4 - 2
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
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

