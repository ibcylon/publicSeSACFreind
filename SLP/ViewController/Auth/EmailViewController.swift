//
//  NicknameViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import UIKit
import RxSwift

class EmailViewController: UIViewController {
    
    var viewModel = EmailViewModel()
    let mainView = EmailView()
    let disposeBag = DisposeBag()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.button.setTitle("다음", for: .normal)
        mainView.titleLabel.text = viewModel.title
        mainView.descriptionLabel.text = viewModel.description
        mainView.emailTextField.placeholder = viewModel.placeholder
        bind()
    }
    
    func bind(){
        let input = EmailViewModel.Input(email: mainView.emailTextField.rx.text, tap: mainView.button.rx.tap)
        
        let output = viewModel.transform(input: input)
        
//        output.validStatus
//            .asDriver(onErrorJustReturn: false)
//
//            .drive(mainView.button.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe {
                print("Click")
                self.navigationController?.pushViewController(BirthViewController(), animated: true)
            }
    }
}
