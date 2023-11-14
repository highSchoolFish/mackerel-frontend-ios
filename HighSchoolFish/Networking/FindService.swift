//
//  FindService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/31.
//

import Foundation
import Moya

enum FindService {
    case findPw(params: FindPwRequest)
    case changePw(params: ChangePwRequest, pwToken: String)
}

extension FindService: TargetType {
    var baseURL: URL {
        return URL(string: "http://high-school-fish.com:8080")!
    }
    
    var path: String {
        switch self {
        case .findPw:
            return "/api/v1/members/password/token"
        case .changePw:
            return "/api/v1/members/password"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .findPw:
            return .post
        case .changePw:
            return .put
        }
    }
    
    var sampleData: Data {
        switch self {
        case .findPw, .changePw:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .findPw(let params):
            return .requestJSONEncodable(params)
        case .changePw(let params, _):
            return .requestJSONEncodable(params)
        }
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        switch self {
        case .findPw:
            return ["Content-type": "application/json"]
        case .changePw(_, let pwToken):
            return ["Content-type": "application/json", "Authorization": "\(pwToken)"]
        }
    }
    
}
