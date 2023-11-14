//
//  PopularTableView.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/18/23.
//

import Foundation
import UIKit

class PopularTableView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("loadXib1")

        loadXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("loadXib2")

        loadXib()
    }
    
    private func loadXib() {
        
        print("loadXib")
        let bundle = Bundle(for: PopularTableView.self)
        let nib = UINib(nibName: "PopularTableView", bundle: bundle)
        let view = nib.instantiate(withOwner: self).first! as! UIView
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

