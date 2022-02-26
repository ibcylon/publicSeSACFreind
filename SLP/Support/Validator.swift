//
//  Validation.swift
//  SLP
//
//  Created by Kanghos on 2022/02/25.
//

import Foundation

enum RegExpression {
    case email
    case phoneNumber
}

extension RegExpression {

    var expresion: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .phoneNumber:
            return "^01[0-1, 7][0-9]{7,8}$"
        }
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String?) throws -> String
}

enum ValidatorType {
    case email
    case phoneNumber
    case hobby
    case nickname
    case birth
    case verificationCode
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email:
            return EmailValidator()
        default :
            return EmailValidator()
    }
}

class EmailValidator: ValidatorConvertible {

    func validated(_ value: String?) throws -> String {
        let regex = try? NSRegularExpression(pattern: <#T##String#>, options: <#T##NSRegularExpression.Options#>)
        }
    }
}
