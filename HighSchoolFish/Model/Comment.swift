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
    var profile: URL? = URL(string: "")
    var name: String = ""
    var isLike: Bool = false
    var createdAt: String = ""
    var context: String = ""
    var numberOfLikes: Int  = 0
    var childComments: [Comment]? = []
        
    init(commentDictionary: Dictionary<String, Any>) {
        let commentData = commentDictionary
        print("commentData in dictionary")
        print(commentData)
        self.id = commentData["id"] as! String
        self.isWriter = commentData["isWriter"] as! Bool
        if let profileString = commentData["profile"] as? String {
            self.profile = URL(string: profileString)
        } else {
            self.profile = nil
        }
        self.name = commentData["name"] as! String
        self.isLike = commentData["isLike"] as! Bool
        self.numberOfLikes = commentData["numberOfLikes"] as! Int
        self.createdAt = commentData["createdAt"] as! String
        self.context = commentData["context"] as! String
        
        // Parse childComments if available
        if let childCommentsData = commentData["childComments"] as? [JSON] {
            self.childComments = childCommentsData.map {
                Comment(commentDictionary: $0.dictionaryObject ?? [:])
            }
            print(childCommentsData)
        }
    }
    
}


