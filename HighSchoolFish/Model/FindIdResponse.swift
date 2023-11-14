//
//  FindIdResponse.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/17.
//

import Foundation

// MARK: - FindIDResponse
struct FindIdResponse: Codable {
    let id, createdAt: String
    let data: FindIdData
}

// MARK: - DataClass
struct FindIdData: Codable {
    let memberId, createAt: String

    enum CodingKeys: String, CodingKey {
        case memberId = "memberId"
        case createAt
    }
}
