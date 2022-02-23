//
//  APIService.swift
//  SLP
//
//  Created by Kanghos on 2022/01/20.
//

import Foundation
import Alamofire

enum UserTarget {
    case register(RegisterRequest)
    case login
    case updateFCMtoken(UpdateFCMToken)
    case updateMypage(UpdateMyPageRequest)
    case withdraw
}

extension UserTarget: TargetType {

    var baseURL: String {
        return GeneralAPIComponent.baseURL + "/user"
    }

    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .login:
            return .get
        case .updateFCMtoken:
            return .put
        case .updateMypage:
            return .post
        case .withdraw:
            return .post
        }
    }

    var path: String {
        switch self {
        case .register:
            return ""
        case .login:
            return ""
        case .updateFCMtoken:
            return "/update_fcm_token"
        case .updateMypage:
            return "/update/mypage"
        case .withdraw:
            return "/withdraw"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .register(let registerRequest):
            return .body(registerRequest)
        case .login:
            return .body(nil)
        case .updateFCMtoken(let fcmToken):
            return .body(fcmToken)
        case .updateMypage(let updateMyPageRequest):
            return .body(updateMyPageRequest)
        case .withdraw:
            return .body(nil)
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .register, .withdraw:
            return GeneralAPIComponent.header
        default:
            return GeneralAPIComponent.contentHeader
        }
    }
}
