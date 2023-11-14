//
//  FindPwResponse.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/31.
//

import Foundation

// MARK: - FindPwResponse
struct FindPwResponse: Codable {
    let id, createdAt: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let passwordAuthToken: String
    let passwordAuthTokenExpiresIn: Int
}
