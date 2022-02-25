//
//  ErrorCode.swift
//  SLP
//
//  Created by Kanghos on 2022/02/24.
//

import Foundation

enum APIResponse {

    case success
    case registerSuccess
    case existedUser
    case invalidNickname
    case invalidToken
    case serverError
    case clientError
    case loginSuccess
    case unregister

    case withdrawSuccess
    case alreadyWithdrew

    case updaateSuccess

    case reportSuccess
    case alreadyReported

    case exceedReported
    case requestMatchSuccess
    case cancelPenaltyFirst
    case cancelPenaltySecond
    case cancelPenaltyThird
    case genderNotSelected

    case requestMatchStopSuccess
    case alreadyMatched

    case hobbyRequest
    case hobbyAlreadyRequested
    case hobbyRequestStop

    case hobbyAlreadyAccepted
    case hobbyAlreadyMatched
    case nonHumanError

}

extension APIResponse {

    var message: String {
        switch self {
        case .registerSuccess:
            return "회원가입 성공"
        case .existedUser:
            return "이미 가입한 회원입니다."
        case .invalidNickname:
            return "사용할 수 없는 닉네임입니다."
        case .loginSuccess:
            return "로그인 성공"
        case .unregister:
            return "미가입 회원입니다."
        case .withdrawSuccess:
            return "회원탈퇴 성공"
        case .alreadyWithdrew:
            return "이미 탈퇴된 회원입니다."
        case .updaateSuccess:
            return "업데이트 성공"
        case .reportSuccess:
            return "신고 성공"
        case .alreadyReported:
            return "이미 신고 접수된 유저입니다."
        case .exceedReported:
            return "신고가 누적되어 이용하실 수 없습니다."
        case .requestMatchSuccess:
            return "친구 찾기 요청 성공"
        case .cancelPenaltyFirst:
            return "약속 취소 패널티로, 1분동안 이용하실 수 없습니다."
        case .cancelPenaltySecond:
            return "약속 취소 패널티로, 2분동안 이용하실 수 없습니다."
        case .cancelPenaltyThird:
            return "연속으로 약속을 취소하셔서 3분동안 이용하실 수 없습니다."
        case .genderNotSelected:
            return "새싹 찾기 기능을 이용하기 위해서는 성별이 피룡해요!"
        case .requestMatchStopSuccess:
            return "찾기 중단 요청 성공"
        case .alreadyMatched:
            return "누군가와 취미를 함께하기로 약속하셨어요!"
        case .hobbyRequest:
            return "취미 함께 하기 요청을 보냈습니다."
        case .hobbyRequestStop:
            return "상대방이 취미 함께 하기를 그만두었습니다."
        default :
            return ""
        }
    }
}
