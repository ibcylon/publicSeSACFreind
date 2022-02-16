//
//  NicknameViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import UIKit
import RxSwift
import Toast

class BirthViewController: UIViewController {
    
    var viewModel = BirthViewModel()
    let mainView = BirthView()
    let disposeBag = DisposeBag()
    
   
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.button.setTitle("다음", for: .normal)
        mainView.titleLabel.text = viewModel.title
        
        bind()
        mainView.yearTextField.becomeFirstResponder()
    }
    
    func bind(){
        let input = BirthViewModel.Input(birthdate: mainView.yearTextField.rx.text,  tap: mainView.button.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: mainView.button.rx.validStatus)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                
                //질문: date 변숫 선언을 어디서 해야 하는지? viewmodel? 아니면 viewcontroller
                
                let isAdult = self.viewModel.checkAultAge(self.mainView.datePicker.date)
                if isAdult {
                    
                    UserDefaults.standard.set("\(self.mainView.datePicker.date)", forKey: "birth")
                    
                    self.navigationController?.pushViewController(EmailViewController(), animated: true)
                } else {
                    self.view.endEditing(true)
                    self.view.makeToast("17세 이상만 가입 가능합니다.")
                }
            }
            .disposed(by: disposeBag)
        
        mainView.datePicker.rx.value.subscribe { event in
            
            guard let date = event.element else { return }
            let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
            self.mainView.yearTextField.text = "\(components.year!)"
            self.mainView.monthTextField.text = "\(components.month!)"
            self.mainView.dayTextField.text = "\(components.day!)"
        }
        .disposed(by: disposeBag)
        
        
    }
}

