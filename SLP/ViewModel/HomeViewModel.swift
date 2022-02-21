//
//  HomeViewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/02/10.
//

import Foundation
import RxSwift
import RxCocoa

enum MatchingStatus: Int {
    case normal = 0
    case matching = 1
    case matched = 2

    var image: String {
        switch self {
        case .normal:
            return "default"
        case .matching:
            return "matching"
        case .matched:
            return "matched"
        }
    }
}

final class HomeViewModel {

    private init() {}

    static let shared = HomeViewModel()

    var user: BehaviorSubject<User> = BehaviorSubject(
        value: User(
            id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "", nick: "", birth: "", gender: 0, hobby: "",
            comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0,
            backgroundCollection: [], purchaseToken: [],
            transactionID: [], reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0,
            dodgeNum: 0, ageMin: 0, ageMax: 0, searchable: 1, createdAt: ""
        )
    )

    var onQueueResult: BehaviorSubject<OnQueueResult> = BehaviorSubject(value: OnQueueResult(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    var latitude = BehaviorRelay<Double>(value: 0.0)
    var longitude = BehaviorRelay<Double>(value: 0.0)
    var region = BehaviorRelay<Int>(value: 0)
    var selectedGender: BehaviorRelay<Gender> = BehaviorRelay(value: Gender.none)
    var isLocationEnable = BehaviorRelay<Bool>(value: false)
    var status = BehaviorRelay<MatchingStatus>(value: MatchingStatus.normal)

    var recommendHobbyList: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    var nearFriendList: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    var myHobbyList: BehaviorRelay<[String]> = BehaviorRelay(value: [])

    func calculateRegion(latitude: Double, longitude: Double) {
        self.latitude.accept(latitude)
        self.longitude.accept(longitude)
        
        let strLatitude = String(latitude + 90).components(separatedBy: ["."]).joined()
        let strLongitude = String(longitude + 180).components(separatedBy: ["."]).joined()

        var strRegion = ""
        [strLatitude, strLongitude].forEach { point in
            let range = point[..<point.index(point.startIndex, offsetBy: 5)]
            strRegion += range
        }
        
        self.region.accept(Int(strRegion) ?? 0)
    }
    
    func emitOnQueueDTO() -> OnQueueDTO {
        return OnQueueDTO(region: region.value, lat: latitude.value, long: longitude.value)
    }
    
    func searchNearFriends(onQueueDTO: OnQueueDTO, completion: @escaping (OnQueueResult?, Int?, Error?) -> Void) {
        APIService.onQueue(onqueueDTO: onQueueDTO) { onqueueResult, statuscode, error in
            
            guard let onqueueResult = onqueueResult else {
                return
            }
            
            let foo = onqueueResult.fromQueueDB
            var man: [OnQueueResult.OtherUserInfo] = []
            var woman: [OnQueueResult.OtherUserInfo] = []
            foo.forEach { other in
                switch other.gender {
                case 0:
                    woman.append(other)
                case 1:
                    man.append(other)
                default:
                    return
                }
            }

            self.onQueueResult.onNext(onqueueResult)
            
            completion(onqueueResult, statuscode, error)
        }
    }
}
