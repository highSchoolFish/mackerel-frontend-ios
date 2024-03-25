//
//  Boards.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/1/23.
//

import Foundation
import SwiftyJSON

struct Boards: Codable {
    var boardId = ""
    var title = ""
    var context = ""
    var createdAt = ""
    var numberOfComments = 0
    var numberOfLikes = 0
    var isExistPhoto = true
    var views = 0
    var isWriter: Bool = false
    var writerNickname: String = ""
    var isLike: Bool = false
    var photos: [String] = []
    var writerProfile: URL? = URL(string: "")
    
    // community TableView
    init(boardDictionary: Dictionary<String, Any>) {
        let boardData = JSON(boardDictionary)
        print("boardData \(boardData)")
        self.boardId = boardData["boardId"].stringValue
        self.title = boardData["title"].stringValue
        self.context = boardData["context"].stringValue
        self.numberOfLikes = boardData["numberOfLikes"].intValue
        self.numberOfComments = boardData["numberOfComments"].intValue
        self.isExistPhoto = boardData["isExistPhoto"].boolValue
        self.createdAt = boardData["createdAt"].stringValue
    }
    
    init(detailBoardDictionary: Dictionary<String, Any>) {
        let detailBoardData = JSON(detailBoardDictionary)
        print(detailBoardData)
        self.boardId = detailBoardData["id"].stringValue
        self.title = detailBoardData["title"].stringValue
        self.context = detailBoardData["context"].stringValue
        self.createdAt = detailBoardData["createdAt"].stringValue
        self.numberOfLikes = detailBoardData["numberOfLikes"].intValue
        self.numberOfComments = detailBoardData["numberOfComments"].intValue
        self.isExistPhoto = detailBoardData["isExistPhoto"].boolValue
        self.views = detailBoardData["views"].intValue
        self.isWriter = detailBoardData["isWriter"].boolValue
        self.writerNickname = detailBoardData["writerNickname"].stringValue
        self.isLike = detailBoardData["isLike"].boolValue
        self.photos = detailBoardData["photos"].arrayValue.map { $0.stringValue }
        self.writerProfile = URL(string: detailBoardData["writerProfile"].stringValue)
        print(self.photos.count)
    }
}
