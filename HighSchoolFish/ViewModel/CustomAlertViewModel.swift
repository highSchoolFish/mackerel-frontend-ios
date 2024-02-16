//
//  CustomAlertViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/7/24.
//

import Foundation

protocol CustomAlertDelegate {
    func action()
}

class CustomAlertViewModel {
    var delegate: CustomAlertDelegate?
    static var shared = CustomAlertViewModel()
    
    var titleString: String = ""
    var contentString: String = ""
    var alertType: AlertType = .defaultAlert
    
    var onCancelComplete: ((Bool) -> Void)?
    var onConfirmComplete: ((Bool) -> Void)?
    
    func setCustomAlertData(alert: AlertData) {
        self.titleString = alert.alertTitle
        self.contentString = alert.alertMessage
        self.alertType = alert.alertType
    }
    
    func confirmButtonTapped() {
        print("confirmButtonTapped VM")
        self.onConfirmComplete?(true)
        // 상황에 따른 통신
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped VM")
        self.onCancelComplete?(true)
    }
}
