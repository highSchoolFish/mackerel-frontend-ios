//
//  RegisterViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/07/05.
//

import Foundation
import UIKit
import SwiftyJSON
import Moya
import Alamofire

class RegisterViewModel {
    
    static let shared = RegisterViewModel()
    
    private var adNotifications: Bool = true
    
    private var idString: String = ""
    private var passwordString: String = ""
    private var password2String: String = ""
    private var nicknameString: String = ""
    
    private var schoolNameString: String = ""
    private var gradeString: String = ""
    var imageData : NSData? = nil
    var schoolIdString: String = ""
    
    private var userNameString: String = ""
    private var certificationNumberString: String = ""
    private var phoneNumberString: String = ""
    
    var checkIdString : String = ""
    var checkIdColorString : String = ""
    private var checkPwString : String = ""
    var checkNicknameString : String = ""
    var checkNicknameColorString : String = ""
    
    private var isAlreadyExistId : Bool = true
    private var isAlreadyExistNickname : Bool = true
    
    // MARK: UserInfo
    private var isCheckedId : Bool = false
    private var isCheckedPw : Bool = false
    private var isCheckedNickname : Bool = false
    
    // MARK: SchoolInfo
    private var isSchoolNameFilled : Bool = false
    private var isImagePicked: Bool = false
    private var isGradePicked: Bool = false
    
    // MARK: AuthInfo
    private var isCheckedName : Bool = false
    private var isCheckedPhoneNumber : Bool = false
    private var isCertified: Bool = false
    
    var observableResult: Observable<Bool> = Observable(false)
    
    var result: Bool = false
    // Input
    func setAdNotifications(_ ad: Bool) {
        adNotifications = ad
    }
    
    var onIdCheckResult: ((String, UIColor?) -> Void)?
    var onNicknameCheckResult: ((String, UIColor?) -> Void)?
    var onCheckFilledResult: ((Bool) -> Void)?
    var onSchoolResult: (([School]) -> Void)?
    var onPhoneNumberChecked: ((Bool) -> Void)?
    var onCertifyNumberChecked: ((Bool) -> Void)?
    var onCompleteCertification: ((Bool) -> Void)?
    var onRegisterComplete: ((Bool) -> Void)?
    
    func setIsCheckedId(_ isCheckedId: Bool) {
        self.isCheckedId = isCheckedId
        checkInfoFilled()
    }
    
    func setIsCheckedPw(_ isCheckedPw: Bool) {
        self.isCheckedPw = isCheckedPw
        checkInfoFilled()
    }
    
    func setIsCheckedNickname(_ isCheckedNickname: Bool) {
        self.isCheckedNickname = isCheckedNickname
        checkInfoFilled()
    }
    
    func setIsSchoolNameFilled(_ isSchoolNameFilled: Bool) {
        self.isSchoolNameFilled = isSchoolNameFilled
        checkInfoFilled()
    }
    
    func setIsImagePicked(_ isImagePicked: Bool) {
        self.isImagePicked = isImagePicked
        checkInfoFilled()
    }
    
    func setIsGradePicked(_ isGradePicked: Bool) {
        self.isGradePicked = isGradePicked
        checkInfoFilled()
    }
    
    func setIsCheckedName(_ isCheckedName: Bool) {
        self.isCheckedName = isCheckedName
        checkInfoFilled()
    }
    
    func setIsCheckedPhoneNumber(_ isCheckedPhoneNumber: Bool) {
        self.isCheckedPhoneNumber = isCheckedPhoneNumber
        checkInfoFilled()
    }
    
    func setIsCertified(_ isCertified: Bool) {
        self.isCertified = isCertified
        checkInfoFilled()
    }
    
    //MARK: UserInfoVC
    func setId(_ id: String) {
        self.idString = id
        print("agreements", Agreements.init(adNotifications: adNotifications))
        
        idTextFieldTyped()
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
    
    func setNickname(_ nickname: String) {
        self.nicknameString = nickname
        nicknameTextFieldTyped()
    }
    
    //MARK: SchoolInfoVC
    func setSchoolName(_ schoolName: String) {
        self.schoolNameString = schoolName
        print(schoolNameString)
        schoolNameTextFieldTyped()
    }
    
    func setSchoolId(_ schoolId: String) {
        self.schoolIdString = schoolId
    }
    
    func setGrade(_ grade: String) {
        gradeString = grade
        print(gradeString)
    }
    
    //MARK: AuthInfoVC
    func setUserName(_ userName: String) {
        self.userNameString = userName
        nameTextFieldTyped()
    }
    
    func setPhoneNumber(_ phoneNumber: String) {
        self.phoneNumberString = phoneNumber
        phoneNumberTextFieldTyped()
    }
    
    func setCertificationNumber(_ certificationNumber: String) {
        self.certificationNumberString = certificationNumber
        certificationNumberTextFieldTyped()
    }
    
    func idTextFieldTyped() {
        let minCount = 4
        let maxCount = 15
        let count = idString.count
        
        switch count {
        case 0:
            checkIdString = "아이디는 필수입력 정보입니다."
            checkIdColorString = "red"
            
        case 1..<minCount:
            checkIdString = "아이디는 4~15글자의 영문과 숫자이어야 합니다."
            checkIdColorString = "red"
            
        case minCount...maxCount:
            let idPattern = #"^(?=.*[A-Za-z])(?=.*\d).{\#(minCount),\#(maxCount)}+$"#
            let isVaildPattern = (idString.range(of: idPattern, options: .regularExpression) != nil)
            if isVaildPattern {
                if idString.contains(where: { $0.isWhitespace }) {
                    print("The string contains a whitespace character.")
                    checkIdString = "공백 혹은 특수문자가 입력되었습니다."
                    checkIdColorString = "red"
                }
                else{
                    self.checkIdAlreadyExists()
                }
            }
            else {
                checkIdString = "영문, 숫자가 필수로 입력되어야 합니다."
                checkIdColorString = "red"
            }
        default:
            checkIdString = "아이디는 4~15글자의 영문과 숫자이어야 합니다."
            checkIdColorString = "red"
        }
        self.onIdCheckResult?(checkIdString, UIColor(named: checkIdColorString))
    }
    
    func checkIdAlreadyExists() {
        print("idString \(idString)")
        //task
        
        let provider = MoyaProvider<RegisterService>()
        provider.request(RegisterService.isExistId(id: idString)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print(data.data)
                print(data.statusCode)
                do {
                    let responseJson = JSON(data.data)
                    print("responseJson: \(responseJson)")
                    if responseJson["data"]["isExistence"] == true {
                        print("이미 존재")
                        self.isAlreadyExistId = true
                        self.checkIdString = "이미 존재하는 아이디 입니다."
                        self.checkIdColorString = "red"
                        
                    }
                    else if responseJson["data"]["isExistence"] == false {
                        print("새로운 id")
                        self.isAlreadyExistId = false
                        self.checkIdString = "사용 가능한 아이디 입니다."
                        self.checkIdColorString = "blue"
                    }
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.onIdCheckResult?(self.checkIdString, UIColor(named: self.checkIdColorString))
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
    
    func nicknameTextFieldTyped() {
        let minCount = 2
        let maxCount = 12
        let count = nicknameString.count
        
        switch count {
        case 0:
            checkNicknameString = "닉네임은 필수입력 정보입니다."
            checkNicknameColorString = "red"
        case 1..<minCount:
            checkNicknameString = "닉네임은 4~10글자의 영문과 숫자이어야 합니다."
            checkNicknameColorString = "red"
        case minCount...maxCount:
            let nicknamePattern = #"^(?=.*[A-Za-z])(?=.*\d).{\#(minCount),\#(maxCount)}+$"#
            let isVaildPattern = (nicknameString.range(of: nicknamePattern, options: .regularExpression) != nil)
            if isVaildPattern {
                if nicknameString.contains(where: { $0.isWhitespace }) {
                    print("The string contains a whitespace character.")
                    checkNicknameString = "닉네임에 공백이 존재합니다."
                    checkNicknameColorString = "red"
                } else {
                    self.checkNicknameAlreadyExists()
                }
            } else {
                checkNicknameString = "닉네임은 특수문자 사용이 안됩니다."
                checkNicknameColorString = "red"
            }
        default:
            checkNicknameString = "닉네임은 4~10글자의 영문과 숫자이어야 합니다."
            checkNicknameColorString = "red"
        }
        self.onNicknameCheckResult?(checkNicknameString, UIColor(named: checkNicknameColorString))
        
    }
    
    func checkNicknameAlreadyExists() {
        // 서버통신
        print("nicknameString \(nicknameString)")
        let provider = MoyaProvider<RegisterService>()
        provider.request(RegisterService.isExistNickname(nickname: nicknameString)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print(data.data)
                print(data.statusCode)
                do {
                    let responseJson = JSON(data.data)
                    print("responseJson: \(responseJson)")
                    if responseJson["data"]["isExistence"] == true {
                        print("이미 존재")
                        self.isAlreadyExistNickname = true
                        self.checkNicknameString = "이미 존재하는 닉네임 입니다."
                        self.checkNicknameColorString = "red"
                        //                        self.checkDelegate?.isCheckedNickname(false)
                    }
                    else if responseJson["data"]["isExistence"] == false {
                        print("새로운 nickname")
                        self.isAlreadyExistNickname = false
                        self.checkNicknameString = "사용 가능한 닉네임 입니다."
                        self.checkNicknameColorString = "blue"
                        //                        self.checkDelegate?.isCheckedNickname(true)
                        
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.onNicknameCheckResult?(self.checkNicknameString, UIColor(named: self.checkNicknameColorString))
        }
    }
    
    func schoolNameTextFieldTyped(){
        // 학교검색 TF 작성 시
        // tableView.isHidden = false
        // tableView에 데이터 넣어야함
        // School 모델에
        // network검색 여기서
        
        print("getSchoolInfo")
        print("schoolName \(schoolNameString)")
        let path = "http://43.203.76.213:8080/api/v1/schools/\(schoolNameString)"
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
            var schoolsInResult = [School]()
            switch result {
            case .success(let value as [String:Any]) :
                if let data = value["data"] as? [Dictionary<String,AnyObject>] {
                    data.forEach {
                        schoolsInResult.append(School(schoolDictionary: $0))
                    }
                }
                print("print school : \(schoolsInResult.count)")
                self.onSchoolResult?(schoolsInResult)
                
            case .failure(let error):
                print(error.localizedDescription)
                
            default :
                fatalError()
            }
        }
        //        var alert = HttpStatusClass().HttpStatusExceptionAlert(from: error.response!)
    }
    
    func nameTextFieldTyped() {
        
    }
    
    func phoneNumberTextFieldTyped() {
        if  phoneNumberString.count == 11 {
            // 전화번호 잘 씀
            self.onPhoneNumberChecked?(true)
        }
        else {
            // 전화번호 이상함
            self.onPhoneNumberChecked?(false)
        }
    }
    
    func certificationNumberTextFieldTyped() {
        if certificationNumberString.count == 6 {
            // 인증번호 잘 씀
            self.onCertifyNumberChecked?(true)
        }
        else {
            // 인증번호 이상함
            self.onCertifyNumberChecked?(false)
        }
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
                self.setIsCheckedPhoneNumber(true)
                
                // use the data here
            case .failure(let error):
                print(error.localizedDescription)
                self.setIsCheckedPhoneNumber(false)
            }
        }
    }
    
    func confirmCertifyNumberButtonTapped() {
        let params = ConfirmsCertificationNumberRequest.init(phone: phoneNumberString, number: Int(certificationNumberString)!)
        let provider = MoyaProvider<CertificationService>()
        provider.request(CertificationService.confirmCertification(params: params)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print(data.data)
                print(data.statusCode)
                let confirmsCertifyNumberResponse = try? JSONDecoder().decode(ConfirmCertificationNumberResponse.self, from: data.data)
                
                print("confirm ", confirmsCertifyNumberResponse?.createAt)
                
                self.onCompleteCertification?(true)
                self.setIsCertified(true)
                //                self.checkDelegate?.isCertified(true)
            case .failure(let error):
                print(error.localizedDescription)
                self.setIsCertified(false)
                
                //                var alert = HttpStatusClass().HttpStatusExceptionAlert(from: error.response!)
                //                show(alertTitle: alert.alertTitle, alertMessage: alert.alertMessage)
            }
        }
    }
    
    func checkInfoFilled() {
        print("checkInfoFilled 확인")
        print("isCheckedId", isCheckedId)
        print("isCheckedPw", isCheckedPw)
        print("isCheckedNickname", isCheckedNickname)
        print("isSchoolNameFilled", isSchoolNameFilled)
        print("isImagePicked", isImagePicked)
        print("isGradePicked", isGradePicked)
        print("isCheckedName", isCheckedName)
        print("isCheckedPhoneNumber", isCheckedPhoneNumber)
        print("isCertified", isCertified)
        
        // 0 페이지 확인
        if isCheckedId == true && isCheckedPw == true && isCheckedNickname == true && isSchoolNameFilled == true && isImagePicked == true && isGradePicked == true && isCheckedName == true && isCheckedPhoneNumber == true && isCertified == true {
            print("all true")
            
            result = true
            observableResult.value = result
            //            self.registerButton.backgroundColor = UIColor(named: "main")
            //            self.registerButton.isEnabled = true
        }
        else {
            print("false")
            result = false
            observableResult.value = result
            
            //            self.registerButton.backgroundColor = UIColor(named: "gray")
            //            self.registerButton.isEnabled = false
        }
    }
    
    func registerButtonTapped() {
        print("memberID", idString)
        print("password", password2String)
        print("nickname", nicknameString)
        print("school", schoolNameString)
        print("schoolId", schoolIdString)
        print("grade", gradeString)
        print("name", userNameString)
        print("agreements", Agreements.init(adNotifications: adNotifications))
        print("phone", phoneNumberString)
        let suffixPhoneNumberString = phoneNumberString.suffix(8)
        print(suffixPhoneNumberString)
        
        let params = RegisterRequest(memberID: idString, password: password2String, nickname: nicknameString, school: schoolIdString, grade: gradeString, name: userNameString, agreements: Agreements.init(adNotifications: adNotifications), phone: String(suffixPhoneNumberString))
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase // Use snake case for keys
        encoder.outputFormatting = .prettyPrinted // Add indentation and line breaks for readability
        
        do {
            let jsonData = try encoder.encode(params)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } catch {
            print(error)
        }
        let provider = MoyaProvider<RegisterService>()
        
        //                let imageToData = userImage.jpegData(compressionQuality: 0.7)!
        //                let multipartFormData = MultipartFormData(provider: .data(imageToData), name: "image", fileName: "image.jpg", mimeType: "image/jpg")
        //                multipartFormData.bodyParts.append(params, withName: "info")
        
        provider.request(RegisterService.register(params: params, userImage: imageData! as Data)) { result in
            switch result {
            case .success(let response):
                print("통신성공")
                print(response.data)
                print(response.statusCode)
                self.onRegisterComplete?(true)
                
                
            case .failure(let error):
                print("통신실패")
                print(error.errorCode)
                print(error.response?.statusCode)
                print(error.localizedDescription)
                self.onRegisterComplete?(false)
                var alert = AlertStatusViewModel.shared.HttpStatusExceptionAlert(from: error.response!)
                self.show(alertTitle: alert.alertTitle, alertMessage: alert.alertMessage)
                
                
            }
        }
    }
}
