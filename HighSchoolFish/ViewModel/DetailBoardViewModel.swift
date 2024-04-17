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
    var headerSection: Int = 99999
    var comments: [CommentContent] = []
    var isWriter: Bool = false
    var imagesArray: [String] = []
    private var boardIdString: String = ""
    private var commentIdString: String = ""
    var deleteIdString: String = ""
    var commentCounts: Int = 0
    var numberOfLikes: Int = 0
    
    var getBoardComplete: ((Bool) -> Void)?
    var onBoardComplete: ((Boards) -> Void)?
    var onCommentsResult: ((Comment) -> Void)?
    var onMoreCommentResult: ((Bool) -> Void)?
    var onCommentsCount: ((Int) -> Int)?
    var onCommentCursor: ((Bool) -> Void)?
    var checkCommentTextField: ((Bool) -> Void)?
    var writeCommentComplete: ((Bool) -> Void)?
    var showMoreCellComplete: ((Bool) -> Void)?
    var onCommentDeleteButtonComplete: ((Bool) -> Void)?
    var onCommentDeleteComplete: ((Bool) -> Void)?
    var onCompleteLike: ((Bool) -> Void)?
    var onCompleteDisLike: ((Bool) -> Void)?
    var onCompleteBoardLike: ((Bool) -> Void)?
    var onCompleteBoardDisLike: ((Bool) -> Void)?
    
    // table cell 선택시 setBoardId func 호출
    func setBoardId(_ boardIdString: String){
        self.boardIdString = boardIdString
        if boardIdString != "" {
            self.getDetailBoard()
            self.getComment()
        }
    }
    
    func setDeleteIdString(_ deleteIdString: String) {
        self.deleteIdString = deleteIdString
    }
    
    func setCommentString(_ commentString: String) {
        self.commentString = commentString
    }
    
    func setCommentIdString(_ commentIdString: String) {
        self.commentIdString = commentIdString
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
                    print("data \(data)")
                    var board = Boards(detailBoardDictionary: data)
                    print("board \(board)")
                    DispatchQueue.main.async {
                        self.getBoardComplete?(true)
                    }
                    DispatchQueue.main.async {
                        self.onBoardComplete?(board)
                    }
                    BottomSheetViewModel.shared.setBoardIdString(self.boardIdString)
                    self.commentCounts = board.numberOfComments
                    self.numberOfLikes = board.numberOfLikes
                    
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
    
    func getDetailBoardForRefresh() {
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
                    print("data \(data)")
                    var board = Boards(detailBoardDictionary: data)
                    print("board \(board)")
                    DispatchQueue.main.async {
                        self.commentCounts = board.numberOfComments
                        self.numberOfLikes = board.numberOfLikes
                        self.onBoardComplete?(board)
                    }
                    BottomSheetViewModel.shared.setBoardIdString(self.boardIdString)
                    
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
        
        print("self.boardIdString \(self.boardIdString)")
        let provider = MoyaProvider<CommentService>(session: Session(interceptor: AuthManager()))
        
        provider.request(CommentService.readComment(boardId: self.boardIdString, page: 0, size: 10)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                
                print("response of comment \(data.data)")
                do{
                    let commentResponse = try JSONDecoder().decode(Comment.self, from: data.data)
                    print("comment Response \(commentResponse)")
                    let pageNumber = commentResponse.data.pageNumber
                    let totalElements = commentResponse.data.totalElements
                    print("comment total \(totalElements)")
                    
                    let json = JSON(data.data)
                    DispatchQueue.main.async {
                        self.onCommentsResult?(commentResponse)
                    }
                    self.comments = commentResponse.data.content
                }
                catch {
                    print(error)
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
        print("")
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
                print("boardIdString \(self.boardIdString)")
                let provider = MoyaProvider<CommentService>(session: Session(interceptor: AuthManager()))
                
                provider.request(CommentService.uploadComment(boardId: self.boardIdString, parentCommentId: parentCommentId, context: self.commentString, isAnonymous: self.isAnonymous)) { result in
                    switch result {
                    case let .success(response):
                        print("통신성공")
                        let data = response
                        print("response \(data)")
                        do {
                            DispatchQueue.main.async {
                                self.writeCommentComplete?(true)
                                self.headerSection = 99999
                            }
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
                            self.headerSection = 99999
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
    
    func boardLikeButtonTapped() {
        //VM recommandButtonTapped
        print("VM recommandButtonTapped")
        let provider = MoyaProvider<BoardService>(session: Session(interceptor: AuthManager()))
        provider.request(BoardService.likeBoard(boardId: self.boardIdString)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("like response \(data)")
                
                do {
                    DispatchQueue.main.async {
                        self.onCompleteBoardLike?(true)
                    }
                }
                catch(let err) {
                    print(err.localizedDescription)
                    print("like catch")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("failure")
            }
        }
    }
    
    func boardDisLikeButtonTapped() {
        //VM recommandButtonTapped
        print("VM recommandButtonTapped")
        let provider = MoyaProvider<BoardService>(session: Session(interceptor: AuthManager()))
        provider.request(BoardService.disLikeBoard(id: self.boardIdString)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("dislike response \(data)")
                do {
                    DispatchQueue.main.async {
                        self.onCompleteBoardDisLike?(true)
                    }
                }
                catch(let err) {
                    print(err.localizedDescription)
                    print("like catch")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("failure")
            }
        }
    }
    
    func likeButtonTapped(commentId: String){
        print("comment ID \(commentId)")
        print("likeButtonTapped")
        
        let provider = MoyaProvider<CommentService>(session: Session(interceptor: AuthManager()))
        
        provider.request(CommentService.likeComment(id: commentId)) { result in
            
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("like response \(data)")
                
                do {
                    DispatchQueue.main.async {
                        self.onCompleteLike?(true)
                    }
                }
                catch(let err) {
                    print(err.localizedDescription)
                    print("like catch")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("failure")
            }
        }
        
    }
    
    func disLikeButtonTapped(commentId: String) {
        print("comment ID \(commentId)")
        print("disLikeButtonTapped")
        
        let provider = MoyaProvider<CommentService>(session: Session(interceptor: AuthManager()))
        
        provider.request(CommentService.disLikeComment(id: commentId)) { result in
            
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("disLike response \(data)")
                do {
                    DispatchQueue.main.async {
                        // 좋아요 취소
                        self.onCompleteDisLike?(true)
                        
                    }
                }
                catch(let err){
                    print(err.localizedDescription)
                    print("disLike catch")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("failure")
            }
            
        }
    }
    
    func deleteButtonTapped(comment: CommentContent) {
        let alert = AlertStatusViewModel.shared.AlertForCheck(checkStatus: .deleteComment)
        CustomAlertViewModel.shared.setCustomAlertData(alert: alert)
        DispatchQueue.main.async { // 예시로 비동기 작업 후 딜레이를 준 것
            self.onCommentDeleteButtonComplete?(true)
        }
    }
    
    func deleteComment() {
        DispatchQueue.main.async {
            let provider = MoyaProvider<CommentService>(session: Session(interceptor: AuthManager()))
            print("delete comment id \(self.deleteIdString)")
            provider.request(CommentService.deleteComment(id: self.deleteIdString)) { result in
                switch result {
                case let .success(response):
                    print("delete 통신성공")
                    let data = response
                    print("response \(data)")
                    do {
                        // 통신 성공하면 댓글 refresh 해야함
                        if response.response!.statusCode >= 300 {
                            DispatchQueue.main.async {
                                self.onCommentDeleteComplete?(false)
                            }
                        }
                        else {
                            DispatchQueue.main.async {
                                self.onCommentDeleteComplete?(true)
                            }
                        }
                        
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
