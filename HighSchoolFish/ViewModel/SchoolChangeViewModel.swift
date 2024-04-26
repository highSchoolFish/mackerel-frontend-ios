//
//  SchoolChangeViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 4/26/24.
//

import Foundation
import Moya
import Alamofire

class SchoolChangeViewModel {
    static let shared = SchoolChangeViewModel()
    var imageData : NSData? = nil
    private var schoolIdString: String = ""
    private var schoolNameString: String = ""
    private var gradeString: String = ""
    
    var onSchoolResult: (([School]) -> Void)?
    var onChangeSchoolComplete: ((Bool) -> Void)?
    
    func setGrade(_ gradeString: String) {
        self.gradeString = gradeString
    }
    
    func setSchoolName(_ schoolName: String) {
        self.schoolNameString = schoolName
        print(schoolNameString)
        schoolNameTextFieldTyped()
    }
    
    func setSchoolId(_ schoolId: String) {
        self.schoolIdString = schoolId
    }
    
    func schoolNameTextFieldTyped(){
        // 학교검색 TF 작성 시
        // tableView.isHidden = false
        // tableView에 데이터 넣어야함
        // School 모델에
        // network검색 여기서
        
        print("getSchoolInfo")
        print("schoolName \(schoolNameString)")
        let path = "http://43.203.76.213:8080/api/v1/schools/\(schoolNameString)"
        guard let encodedStr = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = URL(string: encodedStr)!
        // URL 특수문자로 인한 인코딩
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        AF.request(url,method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseJSON { (response) in
            let result = response.result
            var schoolsInResult = [School]()
            switch result {
            case .success(let value as [String:Any]) :
                if let data = value["data"] as? [Dictionary<String,AnyObject>] {
                    data.forEach {
                        schoolsInResult.append(School(schoolDictionary: $0))
                    }
                }
                print("print school : \(schoolsInResult.count)")
                self.onSchoolResult?(schoolsInResult)
                
            case .failure(let error):
                print(error.localizedDescription)
                
            default :
                fatalError()
            }
        }
        //        var alert = HttpStatusClass().HttpStatusExceptionAlert(from: error.response!)
    }
    
    func schoolChangeButtonTapped() {
        let provider = MoyaProvider<MyPageService>(session: Session(interceptor: AuthManager()))
        provider.request(MyPageService.changeSchool(grade: self.gradeString, schoolId: self.schoolIdString, photo: self.imageData! as Data)) { result in
            switch result {
            case .success(let response):
                print("통신성공")
                self.onChangeSchoolComplete?(true)
            case .failure(let error):
                print("통신실패")
                print(error.errorCode)
                self.onChangeSchoolComplete?(false)
                // alert?
            }
        }
    }
}
