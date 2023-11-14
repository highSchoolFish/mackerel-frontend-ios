//
//  CommunityTableViewCell.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/24/23.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateCell(board: Boards) {
        print("generateCell")
        print("generateCell : \(board.title)")
        titleLabel.text = board.title
        contextLabel.text = board.context
        commentLabel.text = "\(board.numberOfComments)"
        likeLabel.text = "\(board.numberOfLikes)"
//        timeLabel.text = board.createAt
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
