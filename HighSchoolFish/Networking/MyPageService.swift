//
//  MyPageService.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/23/24.
//

import Foundation
import Moya

enum MyPageService {
    case likeBoard(type: String, page: Int, size: Int)
    case changeSchool(grade: String, schoolId: String, photo: Data)
}

extension MyPageService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .likeBoard(let type, let page, let size):
            return "/api/v1/boards/type/\(type)/likes"
        case .changeSchool:
            return "/api/v1/members/school-change"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .likeBoard:
            return .get
        case .changeSchool:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .likeBoard, .changeSchool:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .likeBoard(type: let type, page: let page, size: let size):
            let parameters: [String: Any] = [
                "type": type,
                "page": page,
                "size": size
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
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .likeBoard, .changeSchool:
            return ["Content-Type" : "multipart/form-data"]
        }
    }
}
