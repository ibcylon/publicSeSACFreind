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
    case ClientError = 501
}

enum LoginStatusCode: Int {
    case success = 200
    case tokenError = 401
    case unregister = 406
    case serverError = 500
    case clientError = 501
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
