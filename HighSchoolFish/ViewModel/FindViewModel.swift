//
//  FindViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/17.
//

import Foundation
import Moya
import Alamofire
import UIKit

class FindViewModel {
    
    static let shared = FindViewModel()
    
    var idString: String = ""
    var nameString: String = ""
    var phoneNumberString: String = ""
    private var certifyNumberString: String = ""
    var resultIdString: String = ""
    var resultCreateAtString: String = ""
    private var passwordString: String = ""
    private var password2String: String = ""
    private var checkPwString : String = ""
    private var isCheckedPw : Bool = false

    var onPhoneNumberChecked: ((Bool) -> Void)?
    var onCertifyNumberChecked: ((Bool) -> Void)?
    var onCompleteCertification: ((Bool) -> Void)?
    var onFindIdComplete: ((Bool) -> Void)?
    var onCompleteGetToken: ((Bool) -> Void)?
    var onCompleteChangePw: ((Bool) -> Void)?
    
    var accessToken: String = ""
    var expireIn: Int = 0
    
    func setId(_ id: String) {
        self.idString = id
    }
    
    func setName(_ name: String) {
        self.nameString = name
    }
    
    func setPhoneNumber(_ phoneNumber: String) {
        self.phoneNumberString = phoneNumber
        phoneNumberTextFieldTyped()
    }
    
    func setCertifyNumber(_ certifyNumber: String) {
        self.certifyNumberString = certifyNumber
        certifyNumberTextFieldTyped()
    }
    
    func phoneNumberTextFieldTyped() {
        if phoneNumberString.count == 11 {
            // 전화번호 잘 씀
            self.onPhoneNumberChecked?(true)
        }
        else {
            // 전화번호 이상함
            self.onPhoneNumberChecked?(false)
        }
    }
    
    func certifyNumberTextFieldTyped() {
        if certifyNumberString.count == 6 {
            // 인증번호 잘 씀
            self.onCertifyNumberChecked?(true)
        }
        else {
            // 인증번호 이상함
            self.onCertifyNumberChecked?(false)
        }
    }
    
    func setPassword(_ pw: String) -> (String, UIColor?) {
        passwordString = pw
        if passwordString != "" {
            print(passwordString)
            return passwordTextFieldTyped()
        }
        return ("비밀번호는 8~15글자의 영문과 숫자이어야 합니다.", UIColor(named: "red"))
    }
    
    func setPassword2(_ pw2: String) -> (String, UIColor?) {
        password2String = pw2
        if password2String != "" {
            print(password2String)
            return passwordCheckFunc()
        }
        return ("비밀번호가 일치하지 않습니다.", UIColor(named: "red"))
    }
    
    func setIsCheckedPw(_ isCheckedPw: Bool) {
        self.isCheckedPw = isCheckedPw
    }
    
    func sendCertifyNumberButtonTapped() {
        // 문자 전송
        print("sendCertificationMessage func")
        
        
        // 서버통신
        let params = SendCertificationNumberRequest.init(phone: phoneNumberString)
        let provider = MoyaProvider<CertificationService>()
        provider.request(CertificationService.sendCertification(params: params)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print(data.data)
                print(data.statusCode)
                // use the data here
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func confirmCertifyNumberButtonTapped() {
        let params = ConfirmsCertificationNumberRequest.init(phone: phoneNumberString, number: Int(certifyNumberString)!)
        let provider = MoyaProvider<CertificationService>()
        provider.request(CertificationService.confirmCertification(params: params)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print(data.data)
                print(data.statusCode)
                let confirmsCertifyNumberResponse = try? JSONDecoder().decode(ConfirmCertificationNumberResponse.self, from: data.data)
                
                self.onCompleteCertification?(true)
                
            case .failure(let error):
                print(error.localizedDescription)
                //                var alert = HttpStatusClass().HttpStatusExceptionAlert(from: error.response!)
                //                show(alertTitle: alert.alertTitle, alertMessage: alert.alertMessage)
            }
        }
    }
    
    func findIdButtonTapped() {
        // 인증하기 완료 되었을 경우에만.
        
        print("findIdButtonTappe model")
        print("phoneNumberString \(self.phoneNumberString)")
        
        let suffixPhoneNumberString = phoneNumberString.suffix(8)
        print(suffixPhoneNumberString)
        
        let path = "http://43.203.76.213:8080/api/v1/members/name/\(nameString)/phone/\(suffixPhoneNumberString)"
        guard let encodedStr = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = URL(string: encodedStr)!
        // URL 특수문자로 인한 인코딩
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        AF.request(url,method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseJSON { (response) in
            let result = response.result
            switch result {
            case .success(let value as [String:Any]):
                print("통신성공")
                print(value)
                let findIdResponse = try? JSONDecoder().decode(FindIdResponse.self, from: response.data!)
                print("findIDResponse memberID \(findIdResponse?.data.memberId)")
                print("findIDResponse createAt \(findIdResponse?.data.createAt)")
                // 상태코드 200 이면 무조건 성공
                // 10416
                // response 값에 따라 화면전환 -> FindIDResultViewController로
                // onComplete 주고 FindIdViewController에서 전환할까
                
                self.resultIdString = findIdResponse?.data.memberId ?? "존재하지 않습니다."
                self.resultCreateAtString = findIdResponse?.data.createAt ?? ""
                
                self.onFindIdComplete?(true)
                
                self.setName("")
                self.setPhoneNumber("")
                self.setCertifyNumber("")
                
            case .failure(let error):
                print(error.localizedDescription)
                
            default:
                fatalError()
            }
            //여기서 가져온 데이터를 자유롭게 활용하세요.
        }
        
    }
    
    func findPwButtonTapped() {
        print("phoneNumberString \(self.phoneNumberString)")
//
        let suffixPhoneNumberString = phoneNumberString.suffix(8)
        print(suffixPhoneNumberString)

        let params = FindPwRequest(memberId: idString, name: nameString, phone: String(suffixPhoneNumberString))
        
        print("FindPwRequest : memberId \(params.memberId), name \(params.name), phone : \(params.phone)")
        
        let provider_findPw = MoyaProvider<FindService>()
        provider_findPw.request(FindService.findPw(params: params)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print(data.data)
                print(data.statusCode)
                
                let findPwResponse = try? JSONDecoder().decode(FindPwResponse.self, from: data.data)
                self.accessToken = findPwResponse?.data.passwordAuthToken ?? ""
                self.expireIn = findPwResponse?.data.passwordAuthTokenExpiresIn ?? 0
                
                print(self.accessToken)
                print(self.expireIn)
                
                if self.accessToken != "" {
                    print("token Get")
                    self.onCompleteGetToken?(true)
                }
                
            case .failure(let error):
                print("통신실패")
                print(error.localizedDescription)
                print(error.response!.statusCode)

            }
        }
     
    }
    
    func passwordCheckFunc() -> (String, UIColor?) {
        if passwordString != "" && password2String != "" {
            if passwordString == password2String {
                print("pw same")
                return ("비밀번호가 일치합니다.", UIColor(named: "blue"))
            }
            else{
                print("pw different")
                return ("비밀번호가 일치하지 않습니다.", UIColor(named: "red"))
            }
            
        }
        else {
            return ("", UIColor(named: "red"))
        }
    }
    
    func passwordTextFieldTyped() -> (String, UIColor?) {
        
        let minCount = 8
        let maxCount = 15
        let count = passwordString.count
        
        switch count {
        case 0:
            checkPwString = "비밀번호는 필수입력 정보입니다."
            return (checkPwString, UIColor(named: "red"))
        case 1..<minCount:
            checkPwString = "비밀번호는 8~15글자의 영문과 숫자이어야 합니다."
            return (checkPwString, UIColor(named: "red"))
            
        case minCount...maxCount:
            let pwPattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*.()_+=-]).{\#(minCount),\#(maxCount)}+$"#
            let isVaildPattern = (passwordString.range(of: pwPattern, options: .regularExpression) != nil)
            if isVaildPattern {
                if passwordString.contains(where: { $0.isWhitespace }) {
                    print("The string contains a whitespace character.")
                    checkPwString = "비밀번호에 공백이 존재합니다."
                    return (checkPwString, UIColor(named: "red"))
                }
                else{
                    return ("", UIColor(named: "blue"))
                }
            }
            else {
                checkPwString = "영문, 숫자, 특수문자가 필수로 입력되어야 합니다."
                return (checkPwString, UIColor(named: "red"))
            }
        default:
            checkPwString = "비밀번호는 8~15글자의 영문과 숫자이어야 합니다."
            //            checkDelegate?.isCheckedPw(false)
            return (checkPwString, UIColor(named: "red"))
        }
    }
    func pwChangeButtonTapped() {
        // 토큰 유효한지 확인 완료.
        // Header에 Authorization : tokenString 담아서 보내야함
        // Moya.Service에서 그냥 담아도 될듯
        
        let params = ChangePwRequest(newPassword: self.password2String)
        
        let provider_changePw = MoyaProvider<FindService>()
        provider_changePw.request(FindService.changePw(params: params, pwToken: self.accessToken)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print(data.data)
                print(data.statusCode)
                
                // 변경 완료시
                self.onCompleteChangePw?(true)
            case .failure(let error):
                print("통신실패")
                print(error.localizedDescription)
                print(error.response!.statusCode)
                self.onCompleteChangePw?(false)


            }
        }
        
    }
}

