//
//  ErrorStatusViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/7/24.
//

import Foundation
import Moya

enum HttpStatusCode: Int {
    case success = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case conflict = 409
    case serverError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    
    var isSuccess: Bool {
        return (200...299).contains(rawValue)
    }
    
}

enum CheckStatus{
    case none
    case deleteBoard
    case deleteComment
}

class AlertStatusViewModel {
    static let shared = AlertStatusViewModel()

    var errorCode = 0
    var checkStatus: CheckStatus = .none // CheckStatus 인스턴스를 추가
    
    private func setCheckStatus(checkStatus: CheckStatus) {
        self.checkStatus = checkStatus
    }
    
    func HttpStatusExceptionAlert(from errorResponse: Response) -> AlertData {
        let alertData = AlertData.init(alertTitle: "title", alertMessage: "message")
        
        //        let statusCode = errorResponse.statusCode
        let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: errorResponse.data)
        print("error code : \(errorResponse?.code)")
        print("error message : \(errorResponse?.message)")
        
        let errorCode = errorResponse!.code
        switch errorCode {
        case 10411:
            alertData.alertTitle = "아이디 중복"
            alertData.alertMessage = "이미 사용중인 아이디 입니다."
        case 10412:
            alertData.alertTitle = "닉네임 중복"
            alertData.alertMessage = "이미 사용중인 닉네임 입니다."
        case 10413:
            alertData.alertTitle = "정보 불일치"
            alertData.alertMessage = "비밀번호가 일치하지 않습니다."
        case 10414:
            alertData.alertTitle = "미인증 아이디"
            alertData.alertMessage = "미인증된 아이디 입니다.\n학생 인증은 회원가입일로부터 영업일 기준 1~3일 정도 소요됩니다."
        case 10415:
            alertData.alertTitle = "멤버 찾기 실패"
            alertData.alertMessage = "멤버 찾기 실패"
        case 10416:
            alertData.alertTitle = "아이디 찾기 실패"
            alertData.alertMessage = "일치하는 정보가 없습니다."
        case 10417:
            alertData.alertTitle = "비밀번호 찾기 실패"
            alertData.alertMessage = "일치하는 정보가 없습니다."
        case 10418:
            alertData.alertTitle = "회원가입 실패"
            alertData.alertMessage = "이미 가입한 핸드폰 번호입니다."
        case 10419:
            alertData.alertTitle = "인증번호 발송 실패"
            alertData.alertMessage = "인증번호 발송에 실패했습니다.\n다시 시도해주세요."
        case 10420:
            alertData.alertTitle = "인증번호 불일치"
            alertData.alertMessage = "인증번호가 일치하지 않습니다."
        case 10511:
            alertData.alertTitle = ""
            alertData.alertMessage = ""
        case 10512:
            alertData.alertTitle = "존재하지 않는 게시판"
            alertData.alertMessage = "존재하지 않는 게시판입니다. 이미 "
        case 10513:
            alertData.alertTitle = ""
            alertData.alertMessage = ""
        case 10514:
            alertData.alertTitle = ""
            alertData.alertMessage = ""
        case 10515:
            alertData.alertTitle = ""
            alertData.alertMessage = ""
        case 10516:
            alertData.alertTitle = ""
            alertData.alertMessage = ""
        default:
            return AlertData(alertTitle: "default", alertMessage: "defaultMessage")
        }
        alertData.alertType = .onlyConfirm
        return alertData
    }
    
    func AlertForCheck(checkStatus: CheckStatus) -> AlertData {
        let alertData = AlertData.init(alertTitle: "title", alertMessage: "message")
        switch checkStatus {
        case .deleteComment:
            alertData.alertTitle = "삭제"
            alertData.alertMessage = "해당 댓글을 삭제하시겠습니까? \n삭제 시 되돌릴 수 없습니다."
            alertData.alertType = .defaultAlert

        case .deleteBoard:
            alertData.alertTitle = "삭제"
            alertData.alertMessage = "해당 글을 삭제하시겠습니까? \n삭제 시 되돌릴 수 없습니다."
            alertData.alertType = .defaultAlert

        default:
            return AlertData(alertTitle: "Alert for checking (Title)", alertMessage: "Alert for checking (Content)")
        }
        return alertData
        
    }
    
    func alertResult() {
    }
}

