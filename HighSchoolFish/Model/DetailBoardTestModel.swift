//
//  DetailBoardTestModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/10/23.
//

import Foundation

struct DetailBoardTestModel: Codable {
    let boardId, title, context, createAt, writerNickname: String
    let numberOfComments, numberOfLikes, views: Int
    let isExistPhoto, isWriter, isLike: Bool
    let photos: [String]
    let writerProfile: URL?

}
