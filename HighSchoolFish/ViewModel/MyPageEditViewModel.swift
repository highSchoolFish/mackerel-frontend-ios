//
//  MyPageEditViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/9/24.
//

import Foundation
import UIKit
import Moya
import Alamofire
import SwiftyJSON

class MyPageEditViewModel {
    static let shared = MyPageEditViewModel()
    
    var isTextFieldCheck: ((Bool) -> Void)?
    var nicknameString: String = ""
    var nameString: String = ""
    var checkNicknameString: String = ""
    var checkNicknameColorString: String = ""
    
    var nameCheckComplete: ((Bool) -> Void)?
    var nicknameCheckComplete: ((Bool) -> Void)?
    
    private var isAlreadyExistNickname: Bool = true

    var onNicknameCheckResult: ((String, UIColor?) -> Void)?

    func setNickname(nickname: String) {
        self.nicknameString = nickname
        nicknameTextFieldTyped()
    }
    
    func setName(name: String) {
        self.nameString = name
    }
    
    func nicknameTextFieldTyped() {
        let minCount = 4
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
                    }
                    else if responseJson["data"]["isExistence"] == false {
                        print("새로운 nickname")
                        self.isAlreadyExistNickname = false
                        self.checkNicknameString = "사용 가능한 닉네임 입니다."
                        self.checkNicknameColorString = "blue"
                    }
                    DispatchQueue.main.async {
                        self.onNicknameCheckResult?(self.checkNicknameString, UIColor(named: self.checkNicknameColorString))
                    }
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func isSameBeforeNickname() {
        if nicknameString == MemberInfoViewModel.shared.userNicknameString {
            // 같아
            nicknameCheckComplete?(false)
        }
        else {
            // 달라
            nicknameCheckComplete?(true)
        }
    }
    
    func isSameBeforeName() {
        if nameString == MemberInfoViewModel.shared.userNameString {
            // 같아
            nameCheckComplete?(false)
        }
        else {
            // 달라
            nameCheckComplete?(true)
        }
    }
    
    func editButtonTapped() {
        // 버튼 서버 통신 구현
        
    }
}
