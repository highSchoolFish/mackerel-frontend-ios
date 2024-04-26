//
//  SchoolChangeRequestTableViewCell.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/17/24.
//

import UIKit

class SchoolChangeRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stateButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func generateCell() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
