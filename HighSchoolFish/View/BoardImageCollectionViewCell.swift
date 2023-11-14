//
//  BoardImageCollectionViewCell.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/26/23.
//

import UIKit

class BoardImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var deleteImageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor(named: "gray")?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
    }
    

}
