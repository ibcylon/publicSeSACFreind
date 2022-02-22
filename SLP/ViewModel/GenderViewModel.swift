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

enum Gender: Int {
    case none = -1
    case female = 0
    case male = 1
}

class GenderViewModel: CommonViewModel {
    
    var title: String = "성별을 선택해주세요"
    var description: String = "새싹 찾기 기능을 위해 필요해요"
    var placeholder = "sesac@gmail.com"
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요해요")
    var validStatus: Bool = false
    
    var gender = BehaviorRelay<Gender>(value: .none)
    
    var disposeBag = DisposeBag()
    
    var selectedGender: Gender = .none
    
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
        let male = input.maletap
            .scan(false) { (lastState, _) in
                maleSubject.onNext(!lastState)
                print("male lastState: ", lastState)
                print("male presentState: ", !lastState)
                if !lastState == true {
                    femaleSubject.onNext(false)
                }
                return !lastState
            }
        
        let female = input.femaletap
            .scan(false) { lastState, _ in
                femaleSubject.onNext(!lastState)
                print("female lastState: ", lastState)
                print("female presentState: ", !lastState)
                if !lastState == true {
                   // self.selectedGender = .female
                    maleSubject.onNext(false)
                }
                return !lastState
            }
        
        Observable.of(male, female).merge().subscribe { event in
            print(event)
            
        }.disposed(by: disposeBag)

        return Output(maleState: maleSubject, femaleState: femaleSubject, sceneTransition: input.tap) // , buttonStatus: status)
    }
    
    func login(completion: @escaping (Int?, Error?) -> Void) {

        UserAPIService.register { code, error in
            
            completion(code, error)
        }
    }
}
