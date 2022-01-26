//
//  VerifyViewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class VerifyViewModel: CommonViewModel {
    
    var title: String = "인증번호가 문자로 전송되었어요"
    var description: String = "(최대 소모 20초)"
    var disposeBag = DisposeBag()
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요해요")
    
    struct Input {
        let validNumber: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    //유효성 검사
    func transform(input: Input) -> Output {
        let result = input.validNumber
            .orEmpty
            .map { $0.count == 6}
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validStatus: result, validText: validText, sceneTransition: input.tap)
    }
    
}
