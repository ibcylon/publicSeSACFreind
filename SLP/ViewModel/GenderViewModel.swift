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
    
    var selectedGender:Gender = .none
    
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
    
    //유효성 검사
    func transform(input: Input) -> Output {
        
        let male = input.maletap
            .scan(false, accumulator: { (lastState, newValue) in
                
                if !lastState == true {
                    self.selectedGender = .male
                    print("남자 선택됨")
                }
               
                
                return !lastState
            })
        
        let female = input.femaletap
            .scan(false) { lastState, newValue in
                if !lastState == true {
                    self.selectedGender = .female
                    print("여자 선택됨")
                }
                
                return !lastState
            }
        
//        Observable.combineLatest(male, female){ first, second
//             in
//
//            return "\(first) \(second)"
//        }.subscribe{ print("viewModel: ", $0)
//
//        }
//        .disposed(by: disposeBag)
//
        
        //.asDriver(onErrorJustReturn: Gender.none)
        
        //let status = BehaviorRelay<UIButton.Configuration>(value: .filled())
        return Output(maleState: male, femaleState: female, sceneTransition: input.tap) // , buttonStatus: status)
    }
    
    func login(completion: @escaping (Int?, Error?) -> Void){
        
        
        
        APIService.auth(){ code, error in
            completion(code, error)
        }
    }
}
