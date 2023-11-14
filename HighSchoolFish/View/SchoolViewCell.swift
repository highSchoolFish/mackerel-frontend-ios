//
//  SchoolViewCell.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/16.
//

import Foundation
import UIKit

class SchoolViewCell: UITableViewCell {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolAddressLabel: UILabel!
    
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateCell(school: School) {
        print("generateCell")
        print("generateCell : \(school.schoolName)")
        print("generateCell : \(school.address)")
        
        schoolNameLabel.text = "\(school.schoolName)"
        schoolAddressLabel.text = "\(school.address)"

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
