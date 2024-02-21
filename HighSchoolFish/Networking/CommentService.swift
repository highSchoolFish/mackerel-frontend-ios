//
//  CommentService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/11/23.
//

import Foundation
import Moya

enum CommentService {
    case readComment(boardId: String, page: Int, size: Int)
    case uploadComment(boardId: String, parentCommentId: String, context: String, isAnonymous: Bool)
    case uploadCommentRe(boardId: String, context: String, isAnonymous: Bool)
    case likeComment(id: String)
}

extension CommentService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .readComment(let boardId, _, _):
            return "/api/v1/schools/boards/\(boardId)/comments"
        case .uploadComment:
            return "/api/v1/schools/boards/comments"
        case .uploadCommentRe:
            return "/api/v1/schools/boards/comments"
        case .likeComment:
            return "/api/v1/schools/boards/likes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .readComment(_):
            return .get
        case .uploadComment(_):
            return .post
        case .uploadCommentRe(_):
            return .post
        case .likeComment(_):
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .readComment, .uploadComment, .uploadCommentRe, .likeComment:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .readComment(_, let page, let size):
            let params: [String: Any] = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .uploadComment(boardId: let boardId, parentCommentId: let parentCommentId, context: let context, isAnonymous: let isAnonymous):
            var params: [String: Any] = [
                "boardId": boardId,
                "context": context,
                "parentCommentId": parentCommentId,
                "isAnonymous": isAnonymous
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)

        case .uploadCommentRe(boardId: let boardId, context: let context, isAnonymous: let isAnonymous):
            var params: [String: Any] = [
                "boardId": boardId,
                "context": context,
                "isAnonymous": isAnonymous
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .likeComment(id: let id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .readComment, .uploadComment, .uploadCommentRe, .likeComment:
            return ["Content-Type": "application/json"]
        }
    }
}
