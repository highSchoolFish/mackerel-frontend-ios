//
//  NoticeViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/10/24.
//

import Foundation

class NoticeViewModel {
    static var shared = NoticeViewModel()
    private var noticeTitleString: String = ""
    private var createTimeString: String = ""
    private var noticeCategory: String = ""
    
    func setNoticeTitleString(_ title: String) {
        noticeTitleString = title
    }
    
    func setCreateTimeString(_ time: String) {
        createTimeString = time
    }
    
    func setNoticeCategory(_ category: String) {
        
    }
    
    
}
