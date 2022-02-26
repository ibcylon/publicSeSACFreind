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
    
    func transform(input: Input) -> Output
}

final class PhoneViewModel: CommonViewModel {

    var disposeBag = DisposeBag()
    
    struct Input {
        let phoneNumber: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let sceneTransition: ControlEvent<Void>
    }
    
    // 유효성 검사
    func transform(input: Input) -> Output {
        let result = input.phoneNumber
            .orEmpty
            .map { $0.count >= 5}
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validStatus: result, sceneTransition: input.tap)
    }
    
}
