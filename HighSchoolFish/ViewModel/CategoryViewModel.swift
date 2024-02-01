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
        if categoryName  == "academy"{
            self.categoryName = .academy
        }
        if categoryName  == "university"{
            self.categoryName = .university
        }
        if categoryName  == "secret"{
            self.categoryName = .secret
        }
        if categoryName  == "heart"{
            self.categoryName = .heart
        }
        
    }
        

}
