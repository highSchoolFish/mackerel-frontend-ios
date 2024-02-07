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
    var onCancelComplete: ((Bool) -> Void)?
    var onConfirmComplete: ((Bool) -> Void)?

    func confirmButtonTapped() {
        print("confirmButtonTapped VM")
        self.onConfirmComplete?(true)
        // 상황애 따른 통신
        
    }
    
    func cancelButtonTapped() {
        print("cancelButtonTapped VM")
        self.onCancelComplete?(true)
    }
}

