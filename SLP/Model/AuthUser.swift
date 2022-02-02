import Foundation

// MARK: - AuthUser
struct AuthUser: Codable {
    let phoneNumber, fcmToken, nick, birth: String
    let email: String
    let gender: Int

    enum CodingKeys: String, CodingKey {
        case phoneNumber
        case fcmToken = "FCMtoken"
        case nick, birth, email, gender
    }
}
