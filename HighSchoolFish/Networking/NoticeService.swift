//
//  NoticeService.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/4/24.
//

import Foundation
import Moya

enum NoticeService {
    case readNoticeList(page: Int, size: Int)
    case readNoticeDetail(noticeId: String)
    case readNoticeRecent
    case createNoticeAdmin(title: String, context: String)
}

extension NoticeService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.76.213:8080")!
    }
    
    var path: String {
        switch self {
        case .readNoticeList:
            return "/api/v1/notices"
        case .readNoticeDetail(let noticeId):
            return "/api/v1/notices/\(noticeId)"
        case .readNoticeRecent:
            return "/api/v1/notice/recent"
        case .createNoticeAdmin:
            return "/api/admin/v1/notice"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .readNoticeList:
            return .get
        case .readNoticeDetail:
            return .get
        case .readNoticeRecent:
            return .get
        case .createNoticeAdmin:
            return .post
            
        }
    }
    
    var sampleData: Data {
        switch self {
        case .readNoticeList, .readNoticeDetail, .readNoticeRecent, .createNoticeAdmin:
            return "@@".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .readNoticeList(let page, let size):
            let params: [String: Any] = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
           
        case .readNoticeDetail(let noticeId):
            return .requestParameters(parameters: ["noticeId": noticeId], encoding: URLEncoding.queryString)
        case .readNoticeRecent:
            return .requestPlain
        case .createNoticeAdmin(let title, let context):
            var params: [String: Any] = [
                "title": title,
                "context": context
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)

        }
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        switch self {
        case .readNoticeRecent, .readNoticeList, .readNoticeDetail, .createNoticeAdmin:
            return ["Content-type": "application/json"]
        }
    }
    
}
