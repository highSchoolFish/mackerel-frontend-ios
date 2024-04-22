//
//  MyPageViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/17/24.
//

import Foundation
import Moya
import Alamofire

class MyPageViewModel {
    static let shared = MyPageViewModel()
    var alertSwitchComplete: ((Bool) -> Void)?
    func alertSwitch(isOn: Bool) {
        if isOn {
            print("switch on")
            
        }
        else {
            print("switch off")
            
        }
        if let fcmToken = try? KeyChain.shared.read("fcmTokenService", account: "fcmToken") {
            let provider = MoyaProvider<FCMService>(session: Session(interceptor: AuthManager()))
            provider.request(FCMService.notificationSetting(params: NotificationRequest(isOn: isOn, token: fcmToken))) { result in
                
                switch result {
                case let .success(response):
                    print("통신성공")
                    print("response of notiSetting \(response)")
                    DispatchQueue.main.async {
                        self.alertSwitchComplete?(true)
                    }
                case .failure(let err):
                    self.alertSwitchComplete?(false)
                    print(err.localizedDescription)
                    print("failure")
                }
            }
        }
    }
}
