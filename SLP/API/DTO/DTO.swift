import Foundation

struct SignUpDTO: Encodable {
    let phoneNumber: String
       var FCMtoken: String
       let nick: String
       let email: String
       let birth: Date
       var gender: Int
}

struct OnQueueDTO: Encodable {
    let region: Int
    let lat: Double
    let long: Double
}

struct PostQueueDTO: Encodable {
    let type: Int
    let region: Int
    let lat: Double
    let long: Double
    let hf: [String]
}

struct UpdateMypageDTO: Encodable {
    let searchable: Int
    let ageMin: Int
    let ageMax: Int
    let gender: Int
    let hobby: String
}
