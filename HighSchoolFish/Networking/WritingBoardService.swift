//
//  WritingBoardService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/31/23.
//

import Foundation
import Moya
import SwiftyJSON

enum WritingBoardService {
    case writingBoard(params: WritingBoardRequest, images: [Data])
}

extension WritingBoardService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .writingBoard:
            return "/api/v1/schools/boards"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .writingBoard:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .writingBoard:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .writingBoard(let requestDto, let photos):

            var formData: [MultipartFormData] = []
            if let requestData = try? JSONEncoder().encode(requestDto) {
                formData.append(MultipartFormData(provider: .data(requestData), name: "requestDto"))
            }
            // 이미지 데이터 추가
            photos.enumerated().forEach { index, photoData in
                formData.append(MultipartFormData(provider: .data(photoData), name: "photos", fileName: "photo\(index).jpg", mimeType: "image/jpeg"))
            }

            return .uploadMultipart(formData)
        }
        
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String: String]? {
        switch self {
        case .writingBoard:
            return ["Content-Type" : "multipart/form-data"]
        }
    }
}
