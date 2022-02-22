import Foundation

struct RegisterRequest: Encodable {
    let phoneNumber: String
    var FCMtoken: String
    let nick: String
    let email: String
    let birth: Date
    var gender: Int
}

struct UpdateMyPageRequest: Encodable {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let hobby: String
}

struct UpdateFCMToken: Encodable {
    let FCMtoken: String
}
