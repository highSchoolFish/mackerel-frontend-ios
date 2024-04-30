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
    var userIdString: String = ""
    
    private func setUserId(_ userIdString: String) {
        self.userIdString = userIdString
    }
    
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
        print("refreshToken in VM \(refreshToken)")
        
        if let accessToken = KeyChain.shared.read("api/v1/auth/token", account: "accessToken") {
            
            print("accessToken  in VM \(accessToken)")
            let jwt = try? decode(jwt: accessToken)
            print("jwt : ", jwt)
            print("jwt[sub] : ", jwt?["sub"].rawValue as! String)
            self.setUserId(jwt?["sub"].rawValue as! String)
            
        }
    }
    
    func checkToken() {
        KeyChain.shared.read("api/v1/auth/token", account: "accessToken")
        KeyChain.shared.read("api/v1/auth/token", account: "refreshToken")
    }
    
    func getUserInfo() {
        // token 만 확인하면 됨
        print("get User Info LoginService.memberInfo")
        let provider = MoyaProvider<LoginService>(session: Session(interceptor: AuthManager()))
        provider.request(LoginService.memberInfo) { result in
            switch result {
                
            case .success(let response):
                print("통신성공")
                let responseData = response.data
                do {
                    let memberInfoResponse = try JSONDecoder().decode(MemberInfoResponse.self, from: responseData)
                    // 이제 여기서 memberInfoResponse를 사용하여 필요한 데이터에 접근 가능
                    print("data ", memberInfoResponse.data)
                    print(memberInfoResponse)
                    print("Name: \(memberInfoResponse.data.name)")
                    
//                    self.setUserProfile(memberInfoResponse?.data.profile)
                    
                    DispatchQueue.main.async {
                        self.setUserSchoolName(memberInfoResponse.data.schoolName)
                        self.setUserGrade(memberInfoResponse.data.grade)
                        self.setUserName(memberInfoResponse.data.name)
                        self.setUserNickname(memberInfoResponse.data.nickname)
                    }
                } catch {
                    print("Parsing Error: \(error)")
                }
                //                print("name in VM ",memberInfoResponse?.data.data.name ?? "")
                //                print(memberInfoResponse?.data.memberId ?? "")
                //
                
            case .failure(let error):
                print("통신실패")
                print(error.errorCode)
                print(error.response?.statusCode)
                print(error.localizedDescription)
            }
        }
    }
    
    
}
