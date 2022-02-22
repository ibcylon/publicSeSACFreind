//
//  FirebaseAPI.swift
//  SLP
//
//  Created by Kanghos on 2022/01/23.
//

import Foundation
import FirebaseAuth

final class FirebaseAPI {

    static func refreshToken() {

        let currentUserInstance = Auth.auth().currentUser

        currentUserInstance?.getIDTokenForcingRefresh(true) { idToken, error in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            UserManager.idToken = idToken
        }
    }
}
