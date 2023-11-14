//
//  RegisterService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/03.
//

import Foundation
import Moya

enum RegisterService {
    case isExistId(id: String? = nil)
    case isExistNickname(nickname: String? = nil)
    case findSchoolName(schoolName: String)
    case register(params: RegisterRequest, userImage: Data) // 에러의 주 원인
}

extension RegisterService: TargetType {
    var baseURL: URL {
        return URL(string: "http://high-school-fish.com:8080")!
    }
    
    var path: String {
        switch self {
        case .isExistId(let id):
            return "/api/v1/members/id/\(id ?? "test")/exist"
        case .isExistNickname(let nickname):
            return "/api/v1/members/nickname/\(nickname ?? "test")/exist"
        case .findSchoolName(let schoolName):
            let encodedSchoolName = schoolName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            print("encodedSchoolName : \(encodedSchoolName)")
            return "/api/v1/schools/\(encodedSchoolName)"
        case .register:
            return "/api/v1/join"
        }
    }
    
    //각 메소드가 get 인지 post인지 설정가능
    var method: Moya.Method {
        switch self {
        case .isExistId(_):
            return .get
        case .isExistNickname(_):
            return .get
        case .findSchoolName(_):
            return .get
        case .register:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .isExistId, .isExistNickname, .findSchoolName, .register:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .isExistId(let id):
            let params: [String: Any] = [
                "memberId": id!
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .isExistNickname(nickname: let nickname):
            let params: [String: Any] = [
                "nickname": nickname!
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)

        case .findSchoolName:
            return .requestPlain

        case .register(let params, let imageData):
            let userData = try? JSONEncoder().encode(params)
            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "photo", fileName: "photo.jpg", mimeType: "image/jpg")]

            formData.append(Moya.MultipartFormData(provider: .data(userData!), name: "info", mimeType: "application/json"))

            return .uploadMultipart(formData)

        }
        
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String: String]? {
        switch self {
        case .isExistId:
            return ["Content-Type": "application/json"]
        case .isExistNickname:
            return ["Content-Type": "application/json"]
        case .findSchoolName:
            return ["Content-Type": "application/json"]
            
        case .register:
            return ["Content-Type" : "multipart/form-data"]
        }
    }
}

