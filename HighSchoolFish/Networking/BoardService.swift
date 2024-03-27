//
//  BoardService.swift
//  HighSchoolFish
//
//  Created by 강보현 on 3/27/24.
//

import Foundation
import Moya

enum BoardService {
    case likeBoard(boardId: String)
    case disLikeBoard(id: String)
    case deleteBoard(id: String)
    case reportBoard(id: String)
}

extension BoardService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .likeBoard:
            return "/api/v1/schools/boards/likes"
        case .disLikeBoard(let id):
            return "/api/v1/schools/boards/comments/\(id)/likes"
        case .deleteBoard(let id):
            return "/api/v1/schools/boards/\(id)"
        case .reportBoard(id: let id):
            return "/api/v1/schools/boards/\(id)/reports"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .likeBoard:
            return .post
        case .disLikeBoard(_):
            return .delete
        case .deleteBoard(_):
            return .delete
        case .reportBoard(_):
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .likeBoard, .disLikeBoard, .deleteBoard, .reportBoard:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .likeBoard(boardId: let boardId):
            return .requestParameters(parameters: ["boardId": boardId], encoding: JSONEncoding.default)
        case .disLikeBoard:
            return .requestPlain
        case .deleteBoard(id: let id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case .reportBoard(id: let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .likeBoard, .disLikeBoard, .deleteBoard, .reportBoard:
            return ["Content-Type": "application/json"]
        }
    }
}
