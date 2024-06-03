//
//  MyPageService.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/23/24.
//

import Foundation
import Moya

enum MyPageService {
    case likeBoard(type: String, page: Int, size: Int, sort: [String])
    case changeSchool(grade: String, schoolId: String, photo: Data)
    case myBoard(type: String, page: Int, size: Int, sort: [String])
}

extension MyPageService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .likeBoard(let type, _, _, _):
            return "/api/v1/boards/type/\(type)/likes"
        case .changeSchool:
            return "/api/v1/members/school-change"
        case .myBoard(let type, _, _, _):
            return "/api/v1/boards/type/\(type)/written"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .likeBoard:
            return .get
        case .changeSchool:
            return .post
        case .myBoard:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .likeBoard, .changeSchool, .myBoard:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .likeBoard(type: let type, page: let page, size: let size, sort: let sort):
            let parameters: [String: Any] = [
                "page": page,
                "size": size,
                "sort": ["createdAt,DESC"]
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString
            )
        case .changeSchool(grade: let grade, schoolId: let schoolId, photo: let photo):
            let params: [String: String] = [
                "grade": grade,
                "schoolId": schoolId
            ]
            let schoolData = try? JSONEncoder().encode(params)
            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(photo), name: "photo", fileName: "photo.jpg", mimeType: "image/jpg")]
            
            formData.append(Moya.MultipartFormData(provider: .data(schoolData!), name: "requestDto", mimeType: "application/json"))

            return .uploadMultipart(formData)
        case .myBoard(type: let type, page: let page, size: let size, sort: let sort):
            let parameters: [String: Any] = [
                "page": page,
                "size": size,
                "sort": ["createdAt,DESC"]
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .changeSchool:
            return ["Content-Type" : "multipart/form-data"]
        case .likeBoard, .myBoard:
            return ["Content-type": "application/json"]
        }
    }
}
