//
//  MyBoardViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 6/3/24.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

class MyBoardViewModel {
    static let shared = MyBoardViewModel()
    var onBoardsResult: ((BoardList) -> Void)?
    
    func getMyBoard(boardType: String) {
        let provider = MoyaProvider<MyPageService>(session: Session(interceptor: AuthManager()))
        
        provider.request(MyPageService.myBoard(type: boardType, page: 0, size: 10, sort: ["createdAt,DESC"])) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("response of myBoard \(data.data)")
                if let jsonString = String(data: data.data, encoding: .utf8) {
                    print(jsonString)
                }
                do {
                    print(data.data)
                    print(data)
                    let myBoardResponse = try JSONDecoder().decode(BoardList.self, from: data.data)
                    print("myBoard Response \(myBoardResponse)")
                    
                    let json = JSON(data.data)
                    DispatchQueue.main.async {
                        self.onBoardsResult?(myBoardResponse)
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
