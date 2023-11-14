//
//  School.swift
//  HighSchoolFish_MVVM
//
//  Created by 강보현 on 2023/08/16.
//

import Foundation
import SwiftyJSON

struct School: Codable {
    var schoolName = ""
    var address = ""
    var schoolId = ""
    
    init(schoolDictionary: Dictionary<String, Any>) {
        let schoolData = JSON(schoolDictionary)
        print("schoolData \(schoolData)")
        self.schoolName = schoolData["name"].stringValue
        self.address = schoolData["address"].stringValue
        self.schoolId = schoolData["id"].stringValue
    }

}

