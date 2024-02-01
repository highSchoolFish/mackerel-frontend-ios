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
            var multipartData: [MultipartFormData] = []
            
            // `requestDto`를 JSON으로 인코딩하여 멀티파트 폼 데이터에 추가
            if let requestData = try? JSONEncoder().encode(requestDto) {
                multipartData.append(MultipartFormData(provider: .data(requestData), name: "requestDto"))
            }
            
            // `images` 배열의 각 `Data` 객체를 멀티파트 폼 데이터에 추가
            for (index, image) in photos.enumerated() {
                multipartData.append(MultipartFormData(provider: .data(image), name: "photos", fileName: "image\(index).jpg", mimeType: "image/jpeg"))
            }
            
            return .uploadMultipart(multipartData)
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
