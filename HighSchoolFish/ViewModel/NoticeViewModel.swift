//
//  NoticeViewModel.swift
//  HighSchoolFish
//
//  Created by 강보현 on 1/10/24.
//

import Foundation
import Moya

class NoticeViewModel {
    static var shared = NoticeViewModel()
    private var noticeTitleString: String = ""
    private var createTimeString: String = ""
    private var noticeContextString: String = ""
    private var noticeIdString: String = ""
    var getNoticeResult: ((Notice) -> Void)?
    var getNoticeListResult: ((NoticeList) -> Void)?
    var getNoticeDetailResult: ((Notice) -> Void)?
    var getNoticeDetailComplete: ((Bool) -> Void)?
    
    func setNoticeTitleString(_ title: String) {
        noticeTitleString = title
    }
    
    func setCreateTimeString(_ time: String) {
        createTimeString = time
    }
    
    func setNoticeContextString(_ context: String) {
        noticeContextString = context
    }
    
    func setNoticeIdString(_ id: String) {
        noticeIdString = id
    }
    
    func getRecentNotice() {
        print("getRecentNotice")
        
        let provider = MoyaProvider<NoticeService>(session: Session(interceptor: AuthManager()))
        
        provider.request(NoticeService.readNoticeRecent) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("response \(response)")
                do {
                    let noticeResponse = try JSONDecoder().decode(Notice.self, from: data.data)
                    print("notice Response \(noticeResponse)")
                    
                    DispatchQueue.main.async {
                        self.getNoticeResult?(noticeResponse)
                    }
                }
                catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNoticeList() {
        print("getNoticeList")
        
        let provider = MoyaProvider<NoticeService>(session: Session(interceptor: AuthManager()))
        
        provider.request(NoticeService.readNoticeList(page: 0, size: 10)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("response \(response)")
                do {
                    let noticeResponse = try JSONDecoder().decode(NoticeList.self, from: data.data)
                    print("notice Response \(noticeResponse)")
                    
                    DispatchQueue.main.async {
                        self.getNoticeListResult?(noticeResponse)
                    }
                }
                catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNoticeDetail() {
        print("getNoticeDetail")
        
        let provider = MoyaProvider<NoticeService>(session: Session(interceptor: AuthManager()))
        
        provider.request(NoticeService.readNoticeDetail(noticeId: noticeIdString)) { result in
            switch result {
            case let .success(response):
                print("통신성공")
                let data = response
                print("response \(response)")
                
                do {
                    let noticeResponse = try JSONDecoder().decode(Notice.self, from: data.data)
                    print("notice Response \(noticeResponse)")
                    
                    DispatchQueue.main.async {
                        self.getNoticeDetailComplete?(true)
                    }
                    DispatchQueue.main.async {
                        self.getNoticeDetailResult?(noticeResponse)
                    }
                }
                catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
