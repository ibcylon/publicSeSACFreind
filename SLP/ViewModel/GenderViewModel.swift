//
//  VerifyViewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/01/23.
//

import RxSwift
import RxCocoa
import UIKit

final class GenderViewModel: CommonViewModel {
    
    var title: String = "성별을 선택해주세요"
    var description: String = "새싹 찾기 기능을 위해 필요해요"
    var placeholder = ""
    var gender = BehaviorRelay<Gender>(value: .none)
    var disposeBag = DisposeBag()
    
    struct Input {
        let maletap: ControlEvent<Void>
        let femaletap: ControlEvent<Void>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let maleState: Observable<Bool>
        let femaleState: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    // 유효성 검사
    func transform(input: Input) -> Output {
        
        let maleSubject = BehaviorSubject<Bool>(value: false)
        let femaleSubject = BehaviorSubject<Bool>(value: false)

        input.maletap
            .map({ _ in
                switch self.gender.value {
                case .none, .female:
                    return .male
                case .male:
                    return .none
                }
            })
            .share(replay: 1, scope: .whileConnected)
            .asDriver(onErrorJustReturn: .none)
            .drive(gender)
            .disposed(by: disposeBag)

        input.femaletap
            .map({ _ in
                switch self.gender.value {
                case .none, .male:
                    return .female
                case .female:
                    return .none
                }
            })
            .share(replay: 1, scope: .whileConnected)
            .asDriver(onErrorJustReturn: .none)
            .drive(gender)
            .disposed(by: disposeBag)

        gender.bind { selectedGender in
            switch selectedGender {
            case .male:
                maleSubject.onNext(true)
                femaleSubject.onNext(false)
            case .female:
                maleSubject.onNext(false)
                femaleSubject.onNext(true)
            case .none:
                maleSubject.onNext(false)
                femaleSubject.onNext(false)
            }
            debugPrint(selectedGender)
        }.disposed(by: disposeBag)

        return Output(maleState: maleSubject, femaleState: femaleSubject, sceneTransition: input.tap)
    }
    
    func register(completion: @escaping (APIResponse?) -> Void) {

        let request = RegisterRequest(phoneNumber: UserManager.phoneNumber ?? "",
                                      FCMtoken: UserManager.fcmToken ?? "",
                                      nick: UserManager.nickname ?? "",
                                      email: UserManager.email ?? "",
                                      birth: UserManager.birth ?? Date(),
                                      gender: UserManager.gender)

        UserAPIService.register(request: request) { statusCode, _ in
            switch statusCode {
            case 200:
                UserManager.currentState = Scene.main.rawValue
                completion(.registerSuccess)
            case 201:
                UserManager.currentState = Scene.main.rawValue
                completion(.existedUser)
            case 202:
                UserManager.currentState = Scene.nickname.rawValue
                completion(.invalidNickname)
            case 401:
                UserManager.currentState = Scene.nickname.rawValue
                FirebaseAPI.refreshToken()
                completion(.invalidToken)
            default:
                UserManager.currentState = Scene.nickname.rawValue
                completion(.nonHumanError)
            }
        }
    }
}
