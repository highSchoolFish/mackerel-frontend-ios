//
//  WritingBoardRequest.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 10/31/23.
//
//   let writingBoardRequest = try? JSONDecoder().decode(WritingBoardRequest.self, from: jsonData)

import Foundation

// MARK: - WritingBoardRequest
struct WritingBoardRequest: Codable {
    let requestDto: RequestDto
    
    enum CodingKeys: CodingKey {
        case requestDto
    }
}

// MARK: - RequestDto
struct RequestDto: Codable {
    let title, context, categoryName, visibilityType: String
    let isAnonymous: Bool
}
