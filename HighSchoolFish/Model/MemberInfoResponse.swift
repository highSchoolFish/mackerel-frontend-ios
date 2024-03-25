//
//  MemberInfoResponse.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/1/24.
//

//   let memberInfoResponse = try? JSONDecoder().decode(MemberInfoResponse.self, from: jsonData)

import Foundation

// MARK: - MemberInfoResponse
struct MemberInfoResponse: Codable {
    let id, createdAt: String
    let data: MemberInfo
}

// MARK: - DataClass
struct MemberInfo: Codable {
    let profile: String?
    let schoolName, grade, name, nickname: String
}
