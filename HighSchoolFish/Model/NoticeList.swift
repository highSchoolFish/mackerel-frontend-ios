//
//  NoticeList.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/4/24.
//

import Foundation

// MARK: - NoticeList
struct NoticeList: Codable {
    let id, createdAt: String
    let data: NoticeListData
}

struct NoticeListData: Codable {
    let content: [NoticeListContent]
    let pageNumber, pageSize, totalPages, totalElements: Int
}

struct NoticeListContent: Codable {
    let id: String
    let title: String
    let createdAt: String
}
