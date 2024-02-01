//
//  LoginService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/18.
//

import Foundation
import Moya

enum LoginService {
    case memberCertify(id: String? = nil)
    case signIn(params: LoginRequest)
    case memberInfo
}

extension LoginService: TargetType {
    var baseURL: URL {
        // Test Server
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
            
        case .signIn:
            return "/api/v1/login"
        case .memberCertify(id: let id):
            return "/api/test/v1/members/\(id!)/certify"
        case .memberInfo:
            return "/api/v1/members/info"
        }
    }
    
    //각 메소드가 get 인지 post인지 설정가능
    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        case .memberCertify(id: let id):
            return .put
        case .memberInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .signIn:
            return "@@".data(using: .utf8)!
            
        case .memberCertify(id: let id):
            return Data(
                        """
                        {
                            "id": "52f85aa7-78c0-4421-88f0-90bf0f8a325a",
                            "createAt": "2023-01-23716:18:27.1548353",
                            "data": []
                        }
                        """.utf8
            )
        case .memberInfo:
            return "@@".data(using: .utf8)!
            
        }
    }
    
    var task: Task {
        switch self {
        case .signIn(let params):
            return .requestJSONEncodable(params)
            
        case .memberCertify(id: let id):
            let params: [String: Any] = [
                "id": id!
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .memberInfo:
            return .requestPlain
        }
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String: String]? {
        switch self {
        case .signIn:
            return ["Content-Type": "application/json"]
        case .memberCertify(id: let id):
            return ["Content-Type": "application/json"]
        case .memberInfo:
            return ["Content-Type": "application/json"]
        }
    }
}
