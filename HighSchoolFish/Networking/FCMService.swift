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
    case notificationSetting(params: NotificationRequest)
}

extension FCMService: TargetType {
    var baseURL: URL {
        // Test Server
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .sendFCM:
            return "/api/test/v1/send/fcm"
        case .notificationSetting:
            return "/api/v1/notification/setting"
        }
    }

    var method: Moya.Method {
        switch self {
        case .sendFCM:
            return .post
        case .notificationSetting(_):
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
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
