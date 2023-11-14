//
//  LoginViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/18.
//

import Foundation
import UIKit
import Moya

enum LoginStatus {
    case none                // 로그인전
    case validationFailed    // 입력실패
    case loginDenied         // 로그인거절
    case authenticated       // 인증완료
}

class LoginViewModel {
    // 유저가 입력한 글자 데이터
    private var emailString: String = ""
    private var passwordString: String = ""
    var isMemberCertify = true
    var autoLogin: Bool = false
    
    // 로그인 상태 데이터 ⭐️⭐️⭐️
    private var loginStatus: LoginStatus = .none {
        didSet {
            loginStatusChanged(loginStatus)
        }
    }
    
    var loginStatusChanged: (LoginStatus) -> Void = { _ in }
    
    
    func setEmailText(_ email: String) {
        emailString = email
    }
    
    func setPasswordText(_ password: String) {
        passwordString = password
    }
    
    func loginButtonTapped() {
        
        // 유효성 검사 할라면
        guard !emailString.isEmpty && !passwordString.isEmpty else {
            
            // 근데 내가 짠거에서는 여기 들어갈 수가 없어
            // 버튼이 아예 활성화 안되거든 ㅇㅇ
            
            self.loginStatus = .validationFailed
            return
        }
        
        if isMemberCertify == true {
            let params = LoginRequest(memberId: emailString, password: passwordString)
            
            print("UserInfo : memberID \(params.memberId), password \(params.password)")
            
            let provider_login = MoyaProvider<LoginService>()
            provider_login.request(LoginService.signIn(params: params)) { result in
                switch result {
                case let .success(response):
                    print("통신성공")
                    
                    let data = response
                    print(data.data)
                    print(data.statusCode)
                    
                    let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data.data)
                    // optional 벗기기
                    guard let accessToken = loginResponse?.data.accessToken else {
                        return
                    }
                    guard let refreshToken = loginResponse?.data.refreshToken else {
                        return
                    }
                    
                    KeyChain.shared.create("api/v1/auth/token", account: "accessToken", value: accessToken)
                    KeyChain.shared.create("api/v1/auth/token", account: "refreshToken", value: refreshToken)
                    self.loginStatus = .authenticated
                    
                case .failure(let error):
                    print("통신실패")
                    print(error.localizedDescription)
                    print(error.response!.statusCode)
                    
                    self.loginStatus = .loginDenied
                    //                    HttpStatusClass().HttpStatusException(from: error.response!)
                    //                        HttpStatusException(from: error.response!)
                }
                
                
            }
            
        }
        else {
            print("미인증 아이디")
        }
    }
    
    //        APIService.shared.loginTest(username: emailString, password: passwordString) { [unowned self] result in
    //            switch result {
    //            case .success():
    //                self.loginStatus = .authenticated
    //            case .failure(_):
    //                self.loginStatus = .loginDenied
    //            }
    //        }
    
    
    func autoLoginButtonTapped() {
        if self.autoLogin == true {
            UserDefaults.standard.set(self.autoLogin, forKey: "autoLogin")
        }
    }

    // Logic
    func getMainViewModel() -> MainViewModel {
        let mainVM = MainViewModel(userEmail: self.emailString)
        return mainVM
    }
    
}
