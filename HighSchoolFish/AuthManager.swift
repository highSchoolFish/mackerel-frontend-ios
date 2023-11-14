//
//  AuthManager.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/2/23.
//

import Foundation
import UIKit
import Moya
import Alamofire
import SwiftyJSON

class AuthManager: RequestInterceptor {
    
    // 미 로그인 상태(토큰 X)에서도 동작이 가능한 앱이기 때문에 guard문으로 토큰이 없는 경우 completion을 통해 받은 request 그대로 success를 전달하여 api요청이 실행되게 하였습니다.
    // urlString == API_REFRESH_TOKEN 조건을 통해 현재 요청한 request의 url이 토큰 갱신을 위한 url인지 판단하여 맞는 경우 헤더에 refreshToken을 추가합니다.
    // 모든 요청은 adapt 메서드를 통하므로 urlRequest.headers.add(.authorization(bearerToken: accessToken))을 통해 기본적으로 accessToken을 포함시키는 코드도 있습니다.
    
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("http://high-school-fish.com:8080") == true,
              let accessToken = KeyChain.shared.read("api/v1/auth/token", account: "accessToken") else {
            
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.headers.add(name: "Authorization", value: accessToken)
        print(accessToken)
        print(urlRequest.headers)
        print("authorization header input")
        completion(.success(urlRequest))
    }
    
    // retry 메서드는 통신에러가 났을 때 호출되는데 미리 정의된 토큰 만료 에러코드 401이 아닌 다른 에러코드일 경우 completion(.doNotRetryWithError(error))를 통해 retry 하지 않고 넘어갑니다.
    // 에러코드 401(토큰 만료) 일 경우 토큰 갱신을 위한 api를 호출하고(이 경우는 adpat 메서드에서 refreshToken 추가됨) success일 경우 새롭게 전달받은 accessToken과 refreshToken을 각자 앱에 맞는 방식대로 저장한 후 completion(.retry) 코드를 통해 에러 났던 이전 요청을 다시 retry 합니다. 그러면 다시 한번 adapt 메서드가 호출되어 갱신된 accessToken을 헤더에 넣어 요청을 하겠죠?
    // 만약 refreshToken이 만료되었다거나 서버 문제로 토큰이 갱신되지 않았을 경우에는 completion(.doNotRetryWithError(error)) 코드를 통해 이전 요청을 retry 하지 않고 completion에 error를 전달하여 이전 요청에도 error가 전달됩니다.
    // 갱신이 실패한 경우엔 각자 앱에 맞게 로그아웃을 시키는 등의 추가 처리를 해주면 됩니다.
    // 이렇게 RequestInterceptor을 채택하여 메서드를 구현했다면 alamofire를 통해 요청할 때 interceptor 파라미터를 통해 클래스를 전달해주어야 합니다.
    
    func retry(_ request: Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            print("retry not 401 error")
            completion(.doNotRetryWithError(error))
            return
        }
        
        print("for error 401")
        let provider = MoyaProvider<TokenService>()
        guard let refreshToken = KeyChain.shared.read("api/v1/auth/token", account: "refreshToken") else {
            return
        }
        provider.request(TokenService.refreshToken(token: refreshToken)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print(data)
                do {
                    let responseJson = JSON(data.data)
                    print("responseJson:  \(responseJson)")
                    print("accessToken: ", responseJson["data"]["accessToken"])
                    
                    
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
