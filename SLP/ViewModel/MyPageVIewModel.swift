//
//  MypageVIewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/02/04.
//

import Foundation

struct Menu {
    let title: String
    let icon: String
}
struct SesacTitle {
    let title: String
    let isOn: Bool
}

class MypageViewModel: BaseViewModel {
    
    var title: String = "내정보"
    var icon: String = "profile_img"
    var nickName: String = ""
    var menus: [Menu] = [
        Menu(title: "공지사항", icon: "notice"),
        Menu(title: "자주 묻는 질문", icon: "faq"),
        Menu(title: "1:1 문의", icon: "qna"),
        Menu(title: "알림 설정", icon: "setting_alarm"),
        Menu(title: "이용 약관", icon: "permit")
    ]
    var backgroundImage: String?
    var gender: Gender = .none
    var hobby: String?
    var isPhoneSearchable: Bool = false
    var age: Int = 17
    var sesacTitles: [SesacTitle] = []
    
    var userInfo: UserResponse?
    func fetch() {
        nickName = UserDefaults.standard.string(forKey: "nickname") ?? ""
    }
    
    func getUserInfo(completion: @escaping (UserResponse?, Int?, Error?) -> Void) {
        
    }
}
