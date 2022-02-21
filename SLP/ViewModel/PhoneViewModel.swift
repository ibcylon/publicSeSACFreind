//
//  LoginViewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/01/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol CommonViewModel {
    
    associatedtype Output
    associatedtype Input
    var disposeBag: DisposeBag { get set }
    var title: String { get }
    var description: String { get }
    
    func transform(input: Input) -> Output
}

class PhoneViewModel: CommonViewModel {
    
    var title: String = "새싹 서비스 이용을 위해 \n 휴대폰 번호를 입력해 주세요"
    var description: String = ""
    var disposeBag = DisposeBag()
    var validText = BehaviorRelay<String>(value: "형식에 맞는 번호를 입력해 주세요")
    
    struct Input {
        let phoneNumber: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    // 유효성 검사
    func transform(input: Input) -> Output {
        let result = input.phoneNumber
            .orEmpty
            .map { $0.count >= 5}
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validStatus: result, validText: validText, sceneTransition: input.tap)
    }
    
}
