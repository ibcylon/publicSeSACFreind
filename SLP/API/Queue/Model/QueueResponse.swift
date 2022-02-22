import Foundation

struct OnQueueResponse: Decodable {

    var fromQueueDB: [Friends] // 다른 사용자 목록
    var fromQueueDBRequested: [Friends] // 나에게 요청한 다른 사용자 목록
    var fromRecommend: [String] // 서비스에서 추천하는 취미 배열

    struct Friends: Codable {
        let uid: String
        let nick: String
        let lat: Double
        let long: Double
        let reputation: [Int]
        let hf: [String]
        let reviews: [String]
        let gender: Int
        let type: Int
        let sesac: Int
        let background: Int
    }

}

struct MyQueueStateResponse: Decodable {

    var dodged: Int // 취소 여부
    var matched: Int // 매칭 여부
    var reviewed: Int // 리뷰 여부
    var matchedNick: String
    var matchedUid: String
}
