//
//  MessageViewController.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/19.
//

import Foundation
import UIKit

class MessageTabViewController: UIViewController {
    
    private lazy var label: UILabel = {
        var label = UILabel()
        label.text = "test"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configure()
        setupAutolayout()
    }
    
    private func configure() {
        view.addSubview(label)

    }
    
    private func setupAutolayout() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
    
}
