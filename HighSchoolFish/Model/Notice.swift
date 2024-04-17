//
//  Notices.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/11/24.
//

import Foundation


struct Notice: Codable {
    let id, createdAt: String
    let data: NoticeData
}

struct NoticeData: Codable {
    let id, createdAt, title, context: String
}
