//
//  CommentService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/11/23.
//

import Foundation
import Moya

enum CommentService {
    case readComment(boardId: String)
}

extension CommentService: TargetType {
    var baseURL: URL {
        return URL(string:  "http://high-school-fish.com:8080")!
    }
    
    var path: String {
        switch self {
        case .readComment(let boardId):
            return "/api/v1/schools/boards/\(boardId)/comments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .readComment(_):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .readComment:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .readComment:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .readComment:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
