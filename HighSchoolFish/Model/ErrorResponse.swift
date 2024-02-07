//
//  ErrorResponse.swift
//  HighSchoolFish
//
//  Created by 강보현 on 2/7/24.
//

import Foundation

struct ErrorResponse: Codable {
    let code: Int?
    let message: String?
}
