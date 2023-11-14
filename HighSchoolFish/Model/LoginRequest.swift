//
//  LoginRequest.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/06/18.
//

import Foundation

// MARK: - LoginRequest
struct LoginRequest: Codable {
    let memberId, password: String

    enum CodingKeys: String, CodingKey {
        case memberId
        case password
    }
}
