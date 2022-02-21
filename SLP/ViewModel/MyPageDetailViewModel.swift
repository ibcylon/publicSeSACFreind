//
//  MyPageDetailViewModel.swift
//  SLP
//
//  Created by Kanghos on 2022/02/05.
//

import Foundation
import RxCocoa
import RxSwift

final class MyPageDetailViewModel: BaseViewModel {
    
    var userModel: PublishSubject<User>?
    var disposeBag = DisposeBag()
    var minAge = BehaviorRelay<Int>(value: 17)
    var maxAge = BehaviorRelay<Int>(value: 64)
    var searchable = BehaviorRelay<Bool>(value: true)
    var gender = BehaviorRelay<Gender>(value: .male)
    var hobby = BehaviorRelay<String>(value: "")
    
    struct Input {
        let gender: ControlProperty<Gender>
        let hobby: ControlProperty<String>
        let searchable: ControlProperty<Bool>
        let minAge: ControlProperty<Int>
        let maxAge: ControlProperty<Int>
        
    }
    
    func transform(input: Input) {
        input.gender
            .asDriver()
            .drive(self.gender)
            .disposed(by: disposeBag)
        input.minAge
            .asDriver()
            .drive(self.minAge)
            .disposed(by: disposeBag)
        input.maxAge
            .asDriver()
            .drive(self.maxAge)
            .disposed(by: disposeBag)
        input.hobby
            .asDriver()
            .drive(self.hobby)
            .disposed(by: disposeBag)
        input.searchable
            .asDriver()
            .drive(self.searchable)
            .disposed(by: disposeBag)
    }
    
    func getUser(completion: @escaping (User?, Int?, Error?) -> Void) {
        APIService.getUser { user, statusCode, error in
            guard let user = user else {
                return
            }
            guard let statusCode = statusCode else {
                return
            }
            self.userModel?.onNext(user)
            
            completion(user, statusCode, error)
        }
    }
    
    func updateUser(updateDTO: UpdateMypageDTO, completion: @escaping (Int?) -> Void) {
        APIService.updateUser(updateUserDTO: updateDTO) { statusCode, _ in
            guard let statusCode = statusCode else {
                return
            }
           
            completion(statusCode)
        }
    }
}
    
