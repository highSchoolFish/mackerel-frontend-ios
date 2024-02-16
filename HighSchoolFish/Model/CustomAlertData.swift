//
//  CustomAlertData.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/7/24.
//

import Foundation

enum AlertType {
    case onlyConfirm
    case defaultAlert
}

class AlertData {
    var alertTitle : String = ""
    var alertMessage : String = ""
    var alertType: AlertType = .defaultAlert
    
    init(alertTitle: String, alertMessage: String) {
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
    }
}
