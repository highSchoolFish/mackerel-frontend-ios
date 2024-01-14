//
//  NotificationSettingRequest.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/11/24.
//

import Foundation

// MARK: - NotificationSetting
struct NotificationSettingRequest: Codable {
    let isOn, token: String
}
