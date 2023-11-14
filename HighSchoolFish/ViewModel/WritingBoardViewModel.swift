//
//  WritingBoardViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/31/23.
//

import Foundation
import UIKit
import Moya

class WritingBoardViewModel {
    static let shared = WritingBoardViewModel()
    
    private var titleString: String = ""
    private var isAnonymous: Bool = true
    private var contentString: String = ""
    private var imagesArray: [Data] = []
    private var categoryString: String = ""
    private var schoolNameString: String = ""

    
    func setTitleString(_ titleString: String) {
        self.titleString = titleString
    }
    
    func setAnonymous(_ isAnonymous: Bool) {
        self.isAnonymous = isAnonymous
    }
    
    func setContentString(_ contentString: String) {
        self.contentString = contentString
    }
    
    func setImagesArray(_ imagesArray: [Data]) {
        self.imagesArray = imagesArray
        print(imagesArray.count, "view model")
    }
    
    func setCategoryString(_ categoryString: String) {
        self.categoryString = categoryString
    }
    
    func setSchoolNameString(_ schoolNameString: String) {
        self.schoolNameString = schoolNameString
    }
    
    func checkFilled() {
        print("check filled")
        print("titleString : \(titleString)")
        print("isAnonymous: \(isAnonymous)")
        print("contentString: \(contentString)")
        print("imagesArray: \(imagesArray.count)")
        
        if titleString.isEmpty != true && contentString.isEmpty != true {
            // 제목이랑 내용 비어있는지 확인
            // 안비어있으면 서버통신 ㄱㄱ
            
            let params = WritingBoardRequest(requestDto: RequestDto.init(title: titleString, context: contentString, categoryName: "", isAnonymous: isAnonymous, schoolName: schoolNameString))
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase // Use snake case for keys
            encoder.outputFormatting = .prettyPrinted // Add indentation and line breaks for readability
            
            do {
                let jsonData = try encoder.encode(params)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } catch {
                print(error)
            }
            let provider = MoyaProvider<WritingBoardService>()
            
            provider.request(WritingBoardService.writingBoard(params: params, images: imagesArray as [Data])) { result in
                
                switch result {
                case .success(let response):
                    print("통신성공")
                    print(response.data)
                    print(response.statusCode)
                    
                case .failure(let error):
                    print("통신실패")
//                    print(error.errorCode)
                    print(error.response?.statusCode)
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
}
