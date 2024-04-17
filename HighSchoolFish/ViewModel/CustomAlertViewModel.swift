//
//  CustomAlertViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/7/24.
//

import Foundation

//protocol CustomAlertDelegate {
//    func action()
//}

class CustomAlertViewModel {
    static var shared = CustomAlertViewModel()
    
    var titleString: String = ""
    var contentString: String = ""
    var alertType: AlertType = .defaultAlert
    var alertStatus: CheckStatus = .none
    
    var onCancelComplete: ((Bool) -> Void)?
    var onConfirmComplete: ((Bool) -> Void)?

    func setCustomAlertData(alert: AlertData) {
        self.titleString = alert.alertTitle
        self.contentString = alert.alertMessage
        self.alertType = alert.alertType
    }
    
    func setAlertStatus(alertStatus: CheckStatus) {
        self.alertStatus = alertStatus
    }
    
    func confirmButtonTapped(checkStatus: CheckStatus) {
        print("confirmButtonTapped VM")
        switch checkStatus {
        case .none:
            print("checkStatus: none")
        case .deleteBoard:
            print("checkStatus : deleteBoard")
            BottomSheetViewModel.shared.deleteBoard()
        case .reportBoard:
            print("checkStatus : reportBoard")
            BottomSheetViewModel.shared.reportBoard()
        case .deleteComment:
            print("checkStatus : deleteComment")
            DetailBoardViewModel.shared.deleteComment()
        }
        DispatchQueue.main.async {
            self.onConfirmComplete?(true)
        }
        // 상황에 따른 통신
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped VM")
        self.onCancelComplete?(true)
    }
}
