//
//  QueueRequest.swift
//  SLP
//
//  Created by Kanghos on 2022/02/22.
//

import Foundation

// 주변 탐색
struct OnQueueRequest: Encodable {
    let region: Int
    let lat: Double
    let long: Double
}

// 취미 수락 또는 함께하기 요청
struct OtherUser: Encodable {
    let otheruid: String
}

// 취미 찾기 요청
struct QueueRequest: Encodable {
    let type: Int
    let region: Int
    let lat: Double
    let long: Double
    let hf: [String]
}

// 상대방 평가
struct RateRequest: Encodable {
    let otheruid: String
    let reputation: [Int]
    let comment: String
}
