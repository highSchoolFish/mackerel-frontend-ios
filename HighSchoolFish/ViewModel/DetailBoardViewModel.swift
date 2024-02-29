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
    
    private var commentString: String = ""
    private var isAnonymous: Bool = false
    private var headerSection: Int = 99999
    var comments: [CommentContent] = []
    var isWriter: Bool = false
    var imagesArray: [String] = []
    var getBoardComplete: ((Bool) -> Void)?
    var onBoardComplete: ((Boards) -> Void)?
    var onCommentsResult: ((Comment) -> Void)?
    var onMoreCommentResult: ((Bool) -> Void)?
    var onCommentsCount: ((Int) -> Int)?
    var onCommentCursor: ((Bool) -> Void)?
    var checkCommentTextField: ((Bool) -> Void)?
    var writeCommentComplete: ((Bool) -> Void)?
    var showMoreCellComplete: ((Bool) -> Void)?
    
    private var boardIdString: String = ""
    
    // table cell 선택시 setBoardId func 호출
    func setBoardId(_ boardIdString: String){
        self.boardIdString = boardIdString
        if boardIdString != "" {
            getDetailBoard()
            getComment()
        }
    }
    
    func setCommentString(_ commentString: String) {
        self.commentString = commentString
    }
    
    func setAnonymous(_ isAnonymous: Bool) {
        self.isAnonymous = isAnonymous
    }
    
    func setHeaderSection(_ headerSection: Int) {
        self.headerSection = headerSection
    }
    
    func setimageArray(_ imageArray: [String]) {
        self.imagesArray = imageArray
    }
    
    func getHeaderSection() -> Int {
        return headerSection
    }
    
    func getDetailBoard() {
        print("getDetailBoard in")
        // 특수문자 encoding 해야함
        let path = "http://43.203.76.213:8080/api/v1/schools/boards/\(boardIdString)"
        print(path)
        guard let encodedStr = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = URL(string: encodedStr)!
        print(url)
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
                    BottomSheetViewModel.shared.setBoardIdString(self.boardIdString)
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
        
        provider.request(CommentService.readComment(boardId: self.boardIdString, page: 0, size: 10)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                do{
                    
                    let commentResponse = try JSONDecoder().decode(Comment.self, from: data.data)
                    let pageNumber = commentResponse.data.pageNumber
                    let totalElements = commentResponse.data.totalElements
                    let json = JSON(data.data)
                    print(json)
                    self.onCommentsResult?(commentResponse)
//                    self.onCommentsCount?(commentResponse.data.totalElements)
                    self.comments = commentResponse.data.content
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
        print("more comment button tapped in VM")
    }
    
    func commentUploadButtonTapped() {
        print("comment upload button tapped")
        // upload button tapped
        print("comment String : \(commentString)")
        
        var parentCommentId = ""
        print("headerSection \(headerSection)")
        
        if headerSection != 99999 {
            // header section 값 정해졌으면
            parentCommentId = comments[headerSection].id
            print("parentCommentId : \(parentCommentId)")
            
            if self.commentString.trimmingCharacters(in:  .whitespaces).isEmpty {
                // 댓글 비어있음
                print("댓글 비어있음")
            }
            else {
                print("댓글쓰기 통신")
                print("parentCommentId \(parentCommentId)")
                let provider = MoyaProvider<CommentService>(session: Session(interceptor: AuthManager()))
                
                provider.request(CommentService.uploadComment(boardId: self.boardIdString, parentCommentId: parentCommentId, context: self.commentString, isAnonymous: self.isAnonymous)) { result in
                    switch result {
                    case let .success(response):
                        print("통신성공")
                        let data = response
                        print("response \(data)")
                        do {
                            self.writeCommentComplete?(true)
                        }
                        catch(let err) {
                            print(err.localizedDescription)
                            print("catched")
                        }
                    case .failure(let error):
                        
                        self.writeCommentComplete?(false)
                        print(error.localizedDescription)
                        print("failure")
                    }
                    
                }
            }
        }
        else {
            if self.commentString.trimmingCharacters(in:  .whitespaces).isEmpty {
                // 댓글 비어있음
                print("댓글 비어있음")
            }
            else {
                print("댓글쓰기 통신")
                let provider = MoyaProvider<CommentService>(session: Session(interceptor: AuthManager()))
                
                provider.request(CommentService.uploadCommentRe(boardId: self.boardIdString, context: self.commentString, isAnonymous: self.isAnonymous)) { result in
                    switch result {
                    case let .success(response):
                        print("통신성공")
                        let data = response
                        print("response \(data)")
                        do {
                            
                            self.writeCommentComplete?(true)
                        }
                        catch(let err) {
                            print(err.localizedDescription)
                            print("catched")
                        }
                    case .failure(let error):
                        
                        print(error.localizedDescription)
                        print("failure")
                    }
                    
                }
            }
        }
    }
    
    
}

