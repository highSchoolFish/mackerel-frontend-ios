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

// result false
//var alertTitle = CustomAlertViewModel.shared.titleString
//var alertMessage = CustomAlertViewModel.shared.contentString
//var alertType = CustomAlertViewModel.shared.alertType
//let customAlertVC = CustomAlertViewController()
//customAlertVC.show(alertTitle: alertTitle, alertMessage: alertMessage, alertType: alertType, on: self)


//var alert = AlertStatusViewModel.shared.HttpStatusExceptionAlert(from: error.response!)
//
//var alert = AlertStatusViewModel.shared.HttpStatusExceptionAlert(from: error.response!)
//
//CustomAlertViewModel.shared.setCustomAlertData(alert: alert)
