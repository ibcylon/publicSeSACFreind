//
//  NicknameView.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import RxSwift
import RxCocoa
import Foundation

class BirthViewModel: CommonViewModel {
    
    var disposeBag =  DisposeBag()
    var title: String = "생년월일을 알려주세요"
    var description: String = ""
    var validText = BehaviorRelay<String>(value: "새싹친구는 만 17세 이상만 사용할 수 있습니다")
    var birthdate = BehaviorRelay<Date>(value: Date())
    
    struct Input {
        let birthdate: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let result = input.birthdate
            .orEmpty
            .map { $0.count > 0}
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validStatus: result, validText: validText, sceneTransition: input.tap)
    }
    
    func checkAultAge(_ date: Date) -> Bool {
        let distanceDays = Calendar.current.dateComponents([.day], from: date, to: Date.now)
        //현재까지의 일 수
        
        
        return distanceDays.day! > 6205
    }
}


