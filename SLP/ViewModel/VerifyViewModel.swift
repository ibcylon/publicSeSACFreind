//
//  VerifyViewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/01/23.
//

import Foundation
import RxSwift
import RxCocoa

final class VerifyViewModel: CommonViewModel {

    var title: String = "인증번호가 문자로 전송되었어요"
    var description: String = "(최대 소모 20초)"
    var disposeBag = DisposeBag()
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요해요")
    var second: Int = 60
    let timerSelector: Selector = #selector(updateTime)

    struct Input {
        let validNumber: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let validStatus: Driver<ButtonStatus>
//        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    // 유효성 검사
    func transform(input: Input) -> Output {
        let result = input.validNumber
            .orEmpty
            .map {
                let bool = $0.count == 6 ? true : false
                return bool ? ButtonStatus.fill : ButtonStatus.disable
            }
            .asDriver(onErrorJustReturn: ButtonStatus.disable)
      
        // 타이머
        Timer.scheduledTimer(timeInterval: 1000, target: self, selector: timerSelector, userInfo: nil, repeats: true)
        
        return Output(validStatus: result, sceneTransition: input.tap)
    }
    
    @objc func updateTime() {
        second -= 1
    }
    
    func login(completion:@escaping (Int?, Error?) -> Void) {
        
    }

}
