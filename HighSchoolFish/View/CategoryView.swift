//
//  CategoryView.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/18/23.
//

import Foundation
import UIKit

class CategoryView: UIView {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var freeIcon: UIButton!
    @IBOutlet var freeLabel: UILabel!
    @IBOutlet var academyIcon: UIButton!
    @IBOutlet var academyLabel: UILabel!
    @IBOutlet var universityIcon: UIButton!
    @IBOutlet var universityLabel: UILabel!
    @IBOutlet var secretIcon: UIButton!
    @IBOutlet var secretLabel: UILabel!
    @IBOutlet var heartIcon: UIButton!
    @IBOutlet var heartLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("loadXib1")
        loadXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("loadXib2")
        
        loadXib()
        
        freeIcon.addTarget(self, action: #selector(freeIconTapped), for: .touchUpInside)
        academyIcon.addTarget(self, action: #selector(academyIconTapped), for: .touchUpInside)
        universityIcon.addTarget(self, action: #selector(universityIconTapped), for: .touchUpInside)
        secretIcon.addTarget(self, action: #selector(secretIconTapped), for: .touchUpInside)
        heartIcon.addTarget(self, action: #selector(heartIconTapped), for: .touchUpInside)
    }
    
    private func loadXib() {
        let bundle = Bundle(for: CategoryView.self)
        let nib = UINib(nibName: "CategoryView", bundle: bundle)
        let view = nib.instantiate(withOwner: self).first! as! UIView
        self.addSubview(view)
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.404, green: 0.608, blue: 1, alpha: 0.2).cgColor // 색깔
        view.layer.shadowColor = UIColor(red: 0.404, green: 0.608, blue: 1, alpha: 0.2).cgColor // 색깔
        view.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
        view.layer.shadowRadius = 2 // 반경
        view.layer.shadowOpacity = 1 // alpha값
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    @objc func freeIconTapped() {
        print("freeIconTapped")
        CategoryViewModel.shared.categoryViewTapped(categoryName: "free")
    }
    
    @objc func academyIconTapped() {
        print("academyIconTapped")
        CategoryViewModel.shared.categoryViewTapped(categoryName: "academy")
    }
    
    @objc func universityIconTapped() {
        print("universityIconTapped")
        CategoryViewModel.shared.categoryViewTapped(categoryName: "university")
    }
    
    @objc func secretIconTapped() {
        print("secretIconTapped")
        CategoryViewModel.shared.categoryViewTapped(categoryName: "secret")
    }
    
    @objc func heartIconTapped() {
        print("heartIconTapped")
        CategoryViewModel.shared.categoryViewTapped(categoryName: "heart")
    }
    
    
}
