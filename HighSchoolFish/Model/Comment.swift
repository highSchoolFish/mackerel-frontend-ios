//
//  Cpmment.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/11/23.
//

import Foundation
import SwiftyJSON

// MARK: - Comment
struct Comment: Codable {
    let id, createdAt: String
    let data: CommentData
}

// MARK: - CommentData
struct CommentData: Codable {
    let content: [CommentContent]
    let pageNumber, pageSize, totalPages, totalElements: Int
}

// MARK: - CommentContent
struct CommentContent: Codable {
    let id: String
    let isWriter: Bool
    let profile: URL? = URL(string: "")
    let name: String
    let isLike: Bool
    let numberOfLikes: Int
    let createdAt, context: String
    let childComments: [CommentContent]?
}
