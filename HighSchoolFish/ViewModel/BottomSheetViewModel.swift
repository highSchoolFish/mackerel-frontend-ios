//
//  BottomSheetViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/7/24.
//

import Foundation
import UIKit
import Moya
import Alamofire

class BottomSheetViewModel {
    static let shared = BottomSheetViewModel()
    
    private var boardIdString: String = ""
    
    var onDeleteButtonComplete: ((Bool) -> Void)?
    
    func setBoardIdString(_ boardIdString: String) {
        self.boardIdString = boardIdString
    }
    
    func editButtonTapped() {
        
    }
    
    func reportButtonTapped() {
        let provider = MoyaProvider<BoardService>(session: Session(interceptor: AuthManager()))
        
        provider.request(BoardService.reportBoard(id: boardIdString)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("response \(data)")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteButtonTapped() {
        // alert 떠야함
        // alert 뜨기 전에 BoardBottomSheetVC dismiss
        var alert = AlertStatusViewModel.shared.AlertForCheck(checkStatus: .deleteBoard)
        CustomAlertViewModel.shared.setCustomAlertData(alert: alert)
        self.onDeleteButtonComplete?(true)
    }
    
    func shareButtonTapped() {
        
    }
}
