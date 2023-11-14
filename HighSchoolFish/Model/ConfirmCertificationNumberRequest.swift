//
//  ConfirmCertificationNumberRequest.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/16.
//

import Foundation

// MARK: - ConfirmsCertificationNumberRequest
struct ConfirmsCertificationNumberRequest: Codable {
    let phone: String
    let number: Int
}
