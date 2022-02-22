//
//  APICodeCase.swift
//  SLP
//
//  Created by Kanghos on 2022/02/18.
//

import Foundation

enum APIStatusCode: Int, Error {
    case ok = 200
    case issue1 = 201
    case issue2 = 202
    case issue3 = 203
    case invalidToken = 401
    case unRegister = 406
    case serverError = 500
    case clientError = 501
}
