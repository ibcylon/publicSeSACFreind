//
//  OnQueueResult.swift
//  SLP
//
//  Created by Kanghos on 2022/02/09.
//

import Foundation

import Foundation

struct OnQueueResult: Codable {
    var fromQueueDB: [OtherUserInfo]
    var fromQueueDBRequested: [OtherUserInfo]
    var fromRecommend: [String]
    
    struct OtherUserInfo: Codable {
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

struct RegionModel: Codable {
    var region: Int
    var lat: Double
    var long: Double
    
    enum CodingKeys: String, CodingKey {
        case region, lat, long
    }
}


