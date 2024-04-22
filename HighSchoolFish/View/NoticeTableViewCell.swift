//
//  NoticeTableViewCell.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/8/24.
//

import Foundation
import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noticeImageView: UIImageView!
    @IBOutlet weak var noticeTitleLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateCell(notice: NoticeData) {
        print("generateCell")
        

        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
                    // 셀이 선택되었을 때의 동작
            self.contentView.backgroundColor = UIColor.systemYellow
                } else {
                    // 셀이 선택 해제되었을 때의 동작
                    self.contentView.backgroundColor = UIColor.white
                }
        // Configure the view for the selected state
    }
}
