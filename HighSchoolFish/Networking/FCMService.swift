//
//  FCMService.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/11/24.
//

import Foundation
import Moya

enum FCMService {
    case sendFCM(params: FCMRequest)
    case notificationSetting(params: NotificationSettingRequest)
}

extension FCMService: TargetType {
    
    
    var baseURL: URL {
        // Test Server
        return URL(string: "http://high-school-fish.com:8080")!
        // Mock Server
//        return URL(string: "https://ce0f4e94-cb49-46fc-a25f-f362fd1a4124.mock.pstmn.io")!
    }
    
    var path: String {
        switch self {
        case .sendFCM:
            return "/api/test/v1/send/fcm"
        case .notificationSetting:
            return "/api/v1/notification/setting"
        }
        
    }
    //각 메소드가 get 인지 post인지 설정가능
    var method: Moya.Method {
        switch self {
        case .sendFCM:
            return .post
            
        case .notificationSetting:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .sendFCM, .notificationSetting:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .sendFCM(let params):
            return .requestJSONEncodable(params)
        case .notificationSetting(let params):
            return .requestJSONEncodable(params)
        }
        
    }
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
        
    }
    
}

