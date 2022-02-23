//
//  MyAuthenticator.swift
//  SLP
//
//  Created by Kanghos on 2022/02/22.
//

import Foundation
import Alamofire

final class MyAuthenticator: Authenticator {
    typealias Credential = MyAuthenticationCredential

    func apply(_ credential: MyAuthenticationCredential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(name: "idtoken", value: UserManager.idToken ?? "")
    }

    func refresh(_ credential: MyAuthenticationCredential, for session: Session, completion: @escaping (Result<MyAuthenticationCredential, Error>) -> Void) {

        FirebaseAPI.refreshToken()
        
    }

    // 401 InvalidToken Error만 요청함
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: MyAuthenticationCredential) -> Bool {
        let idToken = UserManager.idToken ?? ""
        return urlRequest.headers["idtoken"] == idToken
    }
}
