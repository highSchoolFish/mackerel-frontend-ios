//
//  WritingBoardService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/31/23.
//

import Foundation
import Moya

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
        case .writingBoard(let params, let imagesData):
            
            var formData: [Moya.MultipartFormData] = []
                    
                    for imageData in imagesData {
                        let photoFormData = Moya.MultipartFormData(provider: .data(imageData), name: "photos", fileName: "photo.jpg", mimeType: "image/jpg")
                        formData.append(photoFormData)
                    }
                    
                    let boardData = try? JSONEncoder().encode(params)
                    formData.append(Moya.MultipartFormData(provider: .data(boardData!), name: "requestDto", mimeType: "application/json"))
//                    
//            let boardData = try? JSONEncoder().encode(params)
//            var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imagesData), name: "photos", fileName: "photo.jpg", mimeType: "image/jpg")]
//            formData.append(Moya.MultipartFormData(provider: .data(boardData!), name: "requestDto", mimeType: "application/json"))

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
