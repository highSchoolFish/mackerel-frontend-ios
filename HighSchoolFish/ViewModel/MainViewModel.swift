//
//  MainViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/18.
//

import Foundation

class MainViewModel {
    
    // 데이터 (모델) ⭐️⭐️⭐️
    private var userEmail: String
    
    // Output
    var userEmailString: String {
        return userEmail
    }
    
    init(userEmail: String) {
        self.userEmail = userEmail
    }
    
    // Logic..
    
}
