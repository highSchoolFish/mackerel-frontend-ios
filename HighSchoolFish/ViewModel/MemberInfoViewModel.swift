//
//  MemberInfoViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/1/24.
//

import Foundation
import Moya
import JWTDecode

class MemberInfoViewModel {
    static let shared = MemberInfoViewModel()
    
    var userProfileString: String = ""
    var userSchoolNameString: String = ""
    var userGradeString: String = ""
    var userNameString: String = ""
    var userNicknameString: String = ""
    
    private func setUserProfile(_ userProfile: String){
        self.userProfileString = userProfile
    }
    
    private func setUserSchoolName(_ userSchoolName: String) {
        self.userSchoolNameString = userSchoolName
    }
    
    private func setUserGrade(_ userGrade: String) {
        self.userGradeString = userGrade
    }
    
    private func setUserName(_ userName: String) {
        self.userNameString = userName
    }
    
    private func setUserNickname(_ userNickname: String){
        self.userNicknameString = userNickname
    }
    
    func decodeJWT() {
        var refreshToken = KeyChain.shared.read("api/v1/auth/token", account: "refreshToken")
        
        if let accessToken = KeyChain.shared.read("api/v1/auth/token", account: "accessToken") {
            let jwt = try? decode(jwt: accessToken)
            print("jwt : ", jwt)
            print("jwt[nickname] : ", jwt?["nickname"])

        }
    }
    
    func checkToken() {
        KeyChain.shared.read("api/v1/auth/token", account: "accessToken")
        KeyChain.shared.read("api/v1/auth/token", account: "refreshToken")
    }
    
    func getUserInfo() {
        // token 만 확인하면 됨
        
        let provider = MoyaProvider<LoginService>()
        provider.request(LoginService.memberInfo) { result in
            switch result {
            case .success(let response):
                print("통신성공")
                print(response.data)
                print(response.statusCode)
                
                let memberInfoResponse = try? JSONDecoder().decode(MemberInfoResponse.self, from: response.data)
                
                self.setUserProfile(memberInfoResponse?.data.profile ?? "")
                self.setUserSchoolName(memberInfoResponse?.data.schoolName ?? "")
                self.setUserGrade(memberInfoResponse?.data.grade ?? "")
                self.setUserName(memberInfoResponse?.data.name ?? "")
                self.setUserNickname(memberInfoResponse?.data.nickname ?? "")
                
            case .failure(let error):
                print("통신실패")
                print(error.errorCode)
                print(error.response?.statusCode)
                print(error.localizedDescription)
            }
        }
    }
    
    
}
