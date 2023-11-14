//
//  AgreementViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/23.
//

import Foundation

class AgreementViewModel {
    
    var adNotifications: Bool = true

    func nextButtonTapped(adNotifications: Bool) {
        self.adNotifications = adNotifications
        
        // 광고 여부 저장
    }
    
    // Logic
    func getRegisterViewModel() -> RegisterViewModel {
        let RegisterVM = RegisterViewModel()
        RegisterVM.setAdNotifications(self.adNotifications)
        return RegisterVM
    }
    
}
