//
//  APICodeCase.swift
//  SLP
//
//  Created by Kanghos on 2022/02/18.
//

import Foundation



enum RegisterStatusCode: Int {
    
    case success = 200
    case existed = 201
    case invalidNickname = 202
    case tokenError = 401
    case serverError = 500
    case clientError = 501
}

extension RegisterStatusCode {
    var message: String {
        switch self {
        case .success:
            return "회원가입 성공"
        case .existed:
            return "이미 가입한 유저입니다."
        case .invalidNickname:
            return "사용할 수 없는 닉네임입니다."
        case .tokenError:
            return "토큰 에러"
        case .serverError:
            return "서버 에러"
        case .clientError:
            return "클라이언트 에러"
        }
    }
}

enum LoginStatusCode: Int {
    case success = 200
    case tokenError = 401
    case unregister = 406
    case serverError = 500
    case clientError = 501
}
extension LoginStatusCode {
    var message: String {
        switch self {
        case .success:
            return "로그인 성공"
        case .tokenError:
            return "토큰 에러"
        case .unregister:
            return "미가입 유저입니다."
        case .serverError:
            return "서버 에러"
        case .clientError:
            return "클라이언트 에러"
        }
    }
}

enum WithdrawStatusCode: Int {
    case success = 200
    case tokenError = 401
    case unregister = 406
    case serverError = 500
}

enum UpdateFCMTokenStatusCode: Int {
    case success = 200
    case tokenError = 401
    case unregister = 406
    case serverError = 500
    case clientError = 501
}

enum UpdateMyPageStatusCode: Int {
    case success = 200
    case tokenError = 401
    case unregister = 406
    case serverError = 500
    case clientError = 501
}

enum ReportStatusCode: Int {
    case success = 200
    case tokenError = 401
    case unregister = 406
    case serverError = 500
    case clientError = 501
}
