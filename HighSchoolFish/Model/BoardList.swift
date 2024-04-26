//
//  BoardList.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/25/24.
//

import Foundation

struct BoardList : Codable {
    let id: String
    let createdAt: String
    let data: BoardListData
}

// `data` 필드에 해당하는 모델
struct BoardListData: Codable {
    let content: [BoardContent]
    let pageNumber, pageSize, totalPages, totalElements: Int
}

// 게시판 내용을 나타내는 모델
struct BoardContent: Codable {
    let boardId, title, context, createdAt: String
    let numberOfComments, numberOfLikes: Int
    let isExistPhoto: Bool
}
