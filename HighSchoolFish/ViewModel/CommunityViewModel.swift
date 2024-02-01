//
//  CommunityViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 11/1/23.
//

import Foundation
import Alamofire
import UIKit

class CommunityViewModel {
    static let shared = CommunityViewModel()
    var onBoardsResult: (([Boards]) -> Void)?

    var categoryNameString: String = ""
    var communityNameString: String = ""
    
    func setCategoryNameString(_ categoryNameString: String) {
        self.categoryNameString = categoryNameString
    }
    
    func setCommunityNameString(_ communityNameString: String) {
        self.communityNameString = communityNameString
    }
    
    func getCategory() {
        print("categoryName")
        print("\(communityNameString), \(categoryNameString)")
        let path = "http://43.203.76.213:8080/api/v1/\(communityNameString)/boards/category/\(categoryNameString)"
        guard let encodedStr = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = URL(string: encodedStr)!
        
        let header : HTTPHeaders = ["Content-type": "application/json"]
        print(header)
        AF.request(url,method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header, interceptor: AuthManager())
        .validate(statusCode: 200..<300)
        .responseJSON { (response) in
            let result = response.result
            print(header)
            var boardsResult = [Boards]()
            switch result {
            case .success(let value as [String:Any]) :
                if let data = value["data"] as? [Dictionary<String,AnyObject>] {
                    data.forEach {
                        boardsResult.append(Boards(boardDictionary: $0))
                    }
                }
                print("print boards : \(boardsResult.count)")
                self.onBoardsResult?(boardsResult)

            case .failure(let error):
                print(error.localizedDescription)
                
            default :
                fatalError()
            }
        }
    }
    
    

}
