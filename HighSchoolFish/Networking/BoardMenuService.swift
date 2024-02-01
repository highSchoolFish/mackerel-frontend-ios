//
//  BoardMenuService.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/1/24.
//

import Foundation
import Moya

enum BoardMenuService {
    case report(id: String)
}

extension BoardMenuService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .report(id: let id):
            return "/api/v1/schools/boards/\(id)/reports"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .report(id: let id):
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .report:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .report(id: let id):
            let params: [String: Any] = [
                "id": id
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String: String]? {
        switch self {
        case .report:
            return ["Content-Type": "application/json"]
        }
    }
}
