//
//  LoginResponse.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/18.
//

import Foundation

struct LoginResponse: Codable {
    let id, createdAt: String
    let data: Token
}

// MARK: - DataClass
struct Token: Codable {
    let accessToken, refreshToken: String
}
