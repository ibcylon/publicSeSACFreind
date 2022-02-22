//
//  APIService.swift
//  SLP
//
//  Created by Kanghos on 2022/01/20.
//

import Foundation
import Alamofire

enum QueueTarget {
    case queue(QueueRequest)
    case onQueue(OnQueueRequest)
    case hobbyRequest(OtherUser)
    case hobbyAccept(OtherUser)
    case dodge(OtherUser)
    case rate(RateRequest)
    case myQueueState
}

extension QueueTarget: TargetType {

    var baseURL: String {
        return GeneralAPIComponent.baseURL + "/queue"
    }

    var method: HTTPMethod {
        switch self {
        case .queue:
            return .post
        case .onQueue:
            return .post
        case .hobbyRequest:
            return .post
        case .hobbyAccept:
            return .post
        case .dodge:
            return .post
        case .rate:
            return .post
        case .myQueueState:
            return .get
        }
    }

    var path: String {
        switch self {
        case .queue:
            return ""
        case .onQueue:
            return "onqueue"
        case .hobbyRequest:
            return "hobbyrequest"
        case .hobbyAccept:
            return "hobbyaccept"
        case .dodge:
            return "dodge"
        case .rate:
            return "rate/"
        case .myQueueState:
            return "myQueueState"
        }
    }

    var parameters: RequestParams {
        switch 
        }
    }
    var headers: HTTPHeaders {
        switch self {
        case .register, .withdraw:
            return GeneralAPIComponent.header
        default:
            return GeneralAPIComponent.contentHeader
        }
    }
}
