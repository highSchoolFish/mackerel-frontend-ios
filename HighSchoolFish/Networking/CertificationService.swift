//
//  CertificationService.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/16.
//

import Foundation
import Moya

enum CertificationService {
    case sendCertification(params: SendCertificationNumberRequest)
    case confirmCertification(params: ConfirmsCertificationNumberRequest)
    
}

extension CertificationService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://high-school-fish.com:8080")!
    }
    
    var path: String {
        switch self {
        case .sendCertification:
            return "/api/v1/messages/certification-numbers"
        case .confirmCertification:
            return "/api/v1/messages/certification-numbers/confirms"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .sendCertification:
            return .post
            
            
        case .confirmCertification:
            return .post
        }
    }
    
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    
    var task: Task {
        switch self {
        case .sendCertification(let params):
            return .requestJSONEncodable(params)
        case .confirmCertification(let params):
            return .requestJSONEncodable(params)
        }
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
