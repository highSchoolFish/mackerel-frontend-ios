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
    var onReportButtonComplete: ((Bool) -> Void)?
    
    func setBoardIdString(_ boardIdString: String) {
        self.boardIdString = boardIdString
    }
    
    func editButtonTapped() {
        
    }
    
    func reportButtonTapped() {
        // alert 떠야함
        // alert 뜨기 전에 BoardBottomSheetVC dismiss
        var alert = AlertStatusViewModel.shared.AlertForCheck(checkStatus: .reportBoard)
        CustomAlertViewModel.shared.setCustomAlertData(alert: alert)
        
        DispatchQueue.main.async {
            self.onReportButtonComplete?(true)
        }
    }
    
    func deleteButtonTapped() {
        // alert 떠야함
        // alert 뜨기 전에 BoardBottomSheetVC dismiss
        
        var alert = AlertStatusViewModel.shared.AlertForCheck(checkStatus: .deleteBoard)
        CustomAlertViewModel.shared.setCustomAlertData(alert: alert)
        DispatchQueue.main.async {
            self.onDeleteButtonComplete?(true)
        }
    }
    
    func shareButtonTapped() {
        
    }
    
    func deleteBoard() {
        let provider = MoyaProvider<BoardService>(session: Session(interceptor: AuthManager()))
        
        provider.request(BoardService.deleteBoard(id: boardIdString)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("response \(data)")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }    }
    
    func reportBoard() {
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
}
