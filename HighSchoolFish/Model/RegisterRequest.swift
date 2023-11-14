//
//  RegisterRequest.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/18.
//


//   let signUpRequest = try? JSONDecoder().decode(SignUpRequest.self, from: jsonData)

import Foundation

// MARK: - SignUpRequest
struct RegisterRequest: Codable {
    let memberID, password, nickname, school: String
    let grade, name: String
    let agreements: Agreements
    let phone: String

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case password, nickname, school, grade, name, phone, agreements
    }
}

// MARK: - Agreements
struct Agreements: Codable {
    let adNotifications: Bool
}
