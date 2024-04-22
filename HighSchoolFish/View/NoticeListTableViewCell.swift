//
//  NoticeListTableViewCell.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/17/24.
//

import UIKit

class NoticeListTableViewCell: UITableViewCell {

    @IBOutlet weak var noticeTitleLabel: UILabel!
    @IBOutlet weak var noticeDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print("selected")
        // Configure the view for the selected state
    }
    
    func generateCell(notice: NoticeListContent) {
        self.noticeTitleLabel.text = notice.title
        
        var timeLabelText = ""
        let givenTimeString = notice.createdAt
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS" // 분수초를 포함한 날짜 형식 지정
        formatter.locale = Locale(identifier: "en_US_POSIX") // 24시간제 지정
        formatter.timeZone = TimeZone.current //

        if let date = formatter.date(from: givenTimeString) {
            // 현재 날짜와 주어진 날짜의 차이 계산
            print("date \(date)")
            let now = Date()
            let calendar = Calendar.current

            // 날짜 차이 계산
            let components = calendar.dateComponents([.day, .hour, .minute], from: date, to: now)
            
            if let daysAgo = components.day, daysAgo > 0 {
                timeLabelText = "\(daysAgo)일 전"
            } else if let hoursAgo = components.hour, hoursAgo > 0 {
                timeLabelText = "\(hoursAgo)시간 전"
            } else if let minutesAgo = components.minute, minutesAgo > 0 {
                timeLabelText = "\(minutesAgo)분 전"
            } else {
                timeLabelText = "방금 전"
            }
        } else {
            print("날짜 형식이 잘못되었습니다.")
        }
        self.noticeDateLabel.text = timeLabelText
    }
}
