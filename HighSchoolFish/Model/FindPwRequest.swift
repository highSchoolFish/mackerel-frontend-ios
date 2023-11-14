//
//  FindPwRequest.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/31.
//

import Foundation

struct FindPwRequest: Codable {
    let memberId, name, phone: String

    enum CodingKeys: String, CodingKey {
        case memberId, name, phone
    }
}
