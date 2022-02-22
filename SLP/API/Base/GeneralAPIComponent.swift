//
//  BaseAPIComponent.swift
//  SLP
//
//  Created by Kanghos on 2022/02/22.
//

import Foundation
import Alamofire

struct GeneralAPIComponent {
    static let baseURL = "http://test.monocoding.com:35484"
    static let idToken = UserManager.idToken!
    static let contentType = "application/x-www-form-urlencoded"

    static let header: HTTPHeaders = ["idtoken": idToken]
    static let contentHeader: HTTPHeaders = ["idtoken": idToken, "Content-Type": contentType]
}
