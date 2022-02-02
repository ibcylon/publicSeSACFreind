//
//  NicknameView.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import RxSwift
import RxCocoa

class NicknameViewModel: CommonViewModel {
    
    var disposeBag =  DisposeBag()
    var title: String = "닉네임을 입력해주세요"
    var description: String = ""
    var placeholder: String = "10자 이내로 입력"
    var validText = BehaviorRelay<String>(value: "닉네임은 1자 이상 10자 이내로 부탁드려요")
    
    struct Input {
        let nickname: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let result = input.nickname
            .orEmpty
            .map { $0.count >= 1 }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validStatus: result, validText: validText, sceneTransition: input.tap)
    }
}
