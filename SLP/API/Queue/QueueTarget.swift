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
    case queueStop
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
        case .queueStop:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .queue, .queueStop:
            return ""
        case .onQueue:
            return "onqueue"
        case .hobbyRequest:
            return "hobbyrequest"
        case .hobbyAccept:
            return "hobbyaccept"
        case .dodge:
            return "dodge"
        case .rate: // uid 추가해야 함.
            return "rate/\(UserManager.otherUID ?? "")"
        case .myQueueState:
            return "myQueueState"
        }
    }

    var parameters: RequestParams {
        switch self {
        case .queue(let queueRequest):
            return .body(queueRequest)
        case .onQueue(let onQueueRequest):
            return .body(onQueueRequest)
        case .hobbyRequest(let otherUser):
            return .body(otherUser)
        case .hobbyAccept(let otherUser):
            return .body(otherUser)
        case .dodge(let otherUser):
            return .body(otherUser)
        case .rate(let rateRequest):
            return .body(rateRequest)
        case .myQueueState, .queueStop:
            return .body(nil)
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .queue, .queueStop, .hobbyRequest, .hobbyAccept, .dodge, .rate:
            return GeneralAPIComponent.header
        case .onQueue, .myQueueState:
            return GeneralAPIComponent.contentHeader
        }
    }
}
