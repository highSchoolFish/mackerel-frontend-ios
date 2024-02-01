//
//  TokenService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/7/23.
//

import Foundation
import Moya

enum TokenService {
    case refreshToken(token: String)
}

extension TokenService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .refreshToken:
            return "api/v1/auth/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .refreshToken:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .refreshToken:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .refreshToken(let params):
            return .requestJSONEncodable(params)
        }
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        switch self {
        case .refreshToken:
            return ["Content-type": "application/json"]
        }
    }
    
}
