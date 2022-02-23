//
//  MyAuthenticationCredential.swift
//  SLP
//
//  Created by Kanghos on 2022/02/22.
//

import Foundation
import Alamofire

struct MyAuthenticationCredential: AuthenticationCredential {

    let accessToken: String
    let refreshToken: String
    let expiredAt: Date

    // 유효시간이 앞으로 20분 이하 남았다면 refresh가 필요하다고 판단 true 리턴
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 20) > expiredAt }

}
