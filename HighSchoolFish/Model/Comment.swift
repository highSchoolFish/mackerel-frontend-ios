//
//  Cpmment.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/11/23.
//

import Foundation
import SwiftyJSON

struct Comment: Codable {
    var id: String = ""
    var isWriter: Bool = false
    var isAnonymous:Bool = false
    var writerProfile: URL? = URL(string: "")
    var name: String = ""
    var isLike: Bool = false
    var createdAt: String = ""
    var context: String = ""
    var childComments: [Comment]? = []
    
    init(commentDictionary: Dictionary<String, Any>) {
        let commentData = JSON(commentDictionary["content"])
        self.id = commentData["id"].stringValue
        self.isWriter = commentData["isWriter"].boolValue
        self.isAnonymous = commentData["isAnonymous"].boolValue
        self.writerProfile = URL(string: commentData["writerProfile"].stringValue)
        self.name = commentData["name"].stringValue
        self.isLike = commentData["isLike"].boolValue
        self.createdAt = commentData["createdAt"].stringValue
        self.context = commentData["context"].stringValue
        
        // Parse childComments if available
        if let childCommentsData = commentData["childComments"].array {
            self.childComments = childCommentsData.map { Comment(commentDictionary: $0.dictionaryObject ?? [:]) }
        }
    }
    
}


