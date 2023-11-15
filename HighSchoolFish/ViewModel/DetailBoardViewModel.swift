//
//  DetailBoardViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/9/23.
//

import Foundation
import UIKit
import Moya
import Alamofire
import SwiftyJSON

class DetailBoardViewModel {
    static let shared = DetailBoardViewModel()
    
    var getBoardComplete: ((Bool) -> Void)?
    var onBoardComplete: ((Boards) -> Void)?
    var onCommentsResult: (([Comment]) -> Void)?
    var onMoreCommentResult: ((Bool) -> Void)?
    
    private var boardIdString: String = ""
    
    // table cell 선택시 setBoardId func 호출
    func setBoardId(_ boardIdString: String){
        self.boardIdString = boardIdString
        if boardIdString != "" {
            getDetailBoard()
            getComment()
        }
    }
    
    func getDetailBoard() {
        print("getDetailBoard in")
        // 특수문자 encoding 해야함
        let path = "http://high-school-fish.com:8080/api/v1/schools/boards/\(boardIdString)"
        print(path)
        guard let encodedStr = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = URL(string: encodedStr)!
        print(url)
        //        guard let accessToken = KeyChain.shared.read("api/v1/auth/token", account: "accessToken") else {
        //            return
        //        }
        let header : HTTPHeaders = ["Content-type": "application/json"]
        print(header)
        AF.request(url, method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header, interceptor: AuthManager())
        .validate(statusCode: 200..<300)
        .responseJSON { (response) in
            let result = response.result
            switch result {
            case .success(let value as [String:Any]) :
                if let data = value["data"] as? Dictionary<String,AnyObject> {
                    print(data)
                    var board = Boards(detailBoardDictionary: data)
                    self.getBoardComplete?(true)
                    self.onBoardComplete?(board)
                    // dic 성공하면 completion -> board
                }
                print("getDetailBoard success")
                
            case .failure(let error):
                print(error.localizedDescription)
                
            default :
                fatalError()
            }
        }
    }
    
    func getComment() {
        
        let provider = MoyaProvider<CommentService>(session: Session(interceptor: AuthManager()))
        
        provider.request(CommentService.readComment(boardId: self.boardIdString, page: 0, size: 1)) { result in
            var commentsResult = [Comment]()
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                do{
                    let responseJson = JSON(data.data)
                    print("responseJson: \(responseJson)")
                    if let commentsData = responseJson["data"]["content"].array {
                        commentsResult = commentsData.map {
                            Comment(commentDictionary: $0.dictionaryObject ?? [:])
                        }
                    }
                    
                    print("print comments: \(commentsResult.count)")
                    self.onCommentsResult?(commentsResult)
                }
                
                catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func moreCommentButtonTapped(){
        self.onMoreCommentResult?(true)
    }
    
    
}

