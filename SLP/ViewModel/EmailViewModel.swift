//
//  VerifyViewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/01/23.
//

import Foundation
import RxSwift
import RxCocoa

class EmailViewModel: CommonViewModel {
    
    var title: String = "이메일을 입력해주세요"
    var description: String = "휴대폰 번호 변경 시 인증을 위해 사용해요"
    var disposeBag = DisposeBag()
    var placeholder = "sesac@gmail.com"
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요해요")
    
    struct Input {
        let email: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Driver<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    //유효성 검사
    func transform(input: Input) -> Output {
        let result = input.email
            .orEmpty
            .map({ _ in
                return true
            })
            .asDriver(onErrorJustReturn: true)
        
        return Output(validStatus: result, validText: validText, sceneTransition: input.tap)
    }
    
    func validate(_ input: String) -> Bool {
            guard
                let regex = try? NSRegularExpression(
                    pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
                    options: [.caseInsensitive]
                )
            else {
                assertionFailure("Regex not valid")
                return false
            }

            let regexFirstMatch = regex
                .firstMatch(
                    in: input,
                    options: [],
                    range: NSRange(location: 0, length: input.count)
                )

            return regexFirstMatch != nil
        }
    
}
