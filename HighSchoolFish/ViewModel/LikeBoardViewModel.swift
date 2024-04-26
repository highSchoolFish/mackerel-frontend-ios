//
//  LikeBoardViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/25/24.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

class LikeBoardViewModel {
    static let shared = LikeBoardViewModel()
    var onBoardsResult: ((BoardList) -> Void)?
    
    func getLikeBoard(boardType: String) {
        let provider = MoyaProvider<MyPageService>(session: Session(interceptor: AuthManager()))
        
        provider.request(MyPageService.likeBoard(type: boardType, page: 0, size: 10)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("response of likeBoard \(data.data)")
                if let jsonString = String(data: data.data, encoding: .utf8) {
                    print(jsonString)
                }
                do {
                    print(data.data)
                    print(data)
                    let likeBoardResponse = try JSONDecoder().decode(BoardList.self, from: data.data)
                    print("likeBoard Response \(likeBoardResponse)")
                    
                    let json = JSON(data.data)
                    DispatchQueue.main.async {
                        self.onBoardsResult?(likeBoardResponse)
                    }
                }
                catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
