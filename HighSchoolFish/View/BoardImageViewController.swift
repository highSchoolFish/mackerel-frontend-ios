//
//  BoardImageViewController.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/17/24.
//

import Foundation
import UIKit
import SafeAreaBrush
import Kingfisher
import ImageSlideshow

class BoardImageViewController: UIViewController {
    var images: [String] = DetailBoardViewModel.shared.imagesArray

    private lazy var closeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.numberOfPages = images.count
        // 페이지 컨트롤의 현재 페이지를 0으로 설정
        pageControl.currentPage = 0
        // 페이지 표시 색상을 밝은 회색 설정
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        // 현재 페이지 표시 색상을 검정색으로 설정
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setAutoLayout()
    }
    
    private func configure() {
        view.backgroundColor = .black
        view.addSubview(closeButton)
        view.addSubview(imageView)
        view.addSubview(pageControl)
        
        fillSafeArea(position: .top, color: .black, gradient: false)
        fillSafeArea(position: .bottom, color: .black, gradient: false)
        
        print(images)
        print(images.count)
        let url = URL(string: images[0])
        self.imageView.kf.setImage(with: url)
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50)
        ])
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pageChanged(_ sender: UIPageControl) {
        // images라는 배열에서 pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imgView에 할당
        print("state changed")
        let currentPage = sender.currentPage
        print(currentPage)
        print(pageControl.currentPage)
        let url = URL(string: images[pageControl.currentPage])
        self.imageView.kf.setImage(with: url)
    }
}
