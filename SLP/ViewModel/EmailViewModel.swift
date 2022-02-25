//
//  VerifyViewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/01/23.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class EmailViewModel: CommonViewModel {
    
    var title: String = "이메일을 입력해주세요"
    var description: String = "휴대폰 번호 변경 시 인증을 위해 사용해요"
    var disposeBag = DisposeBag()
    var placeholder = "sesac@gmail.com"
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요해요")
    
    var validStatus: Bool = false
    
    struct Input {
        let email: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Driver<ButtonStatus>
//        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
        // let buttonStatus: BehaviorRelay<UIButton.Configuration>
    }
    
    // 유효성 검사
    func transform(input: Input) -> Output {
//        let result = input.email
//            .orEmpty
//            .map({ return self.validate($0)
//            })
        let result = input.email.map { text in
            
            let bool = self.validate(text!)
            return bool ? ButtonStatus.fill : ButtonStatus.disable
            
        }
            .asDriver(onErrorJustReturn: ButtonStatus.disable)

        return Output(validStatus: result, sceneTransition: input.tap) 
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
