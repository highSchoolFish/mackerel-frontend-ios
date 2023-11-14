//
//  CategoryViewModel.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/26/23.
//

import Foundation

enum CategoryName {
    case none
    case free
    case academy
    case university
    case secret
    case heart
}

class CategoryViewModel {
    static let shared = CategoryViewModel()
    
    // 로그인 상태 데이터 ⭐️⭐️⭐️
    private var categoryName: CategoryName = .none {
        didSet {
            categoryNameChanged(categoryName)
        }
    }
    
    var categoryNameChanged: (CategoryName) -> Void = { _ in }
    
    
    func categoryViewTapped(categoryName: String) {
        if categoryName  == "free"{
            self.categoryName = .free
        }
    }
        

}
