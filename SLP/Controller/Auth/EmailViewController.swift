//
//  NicknameViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import UIKit
import RxCocoa
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
        mainView.emailTextField.text = UserManager.email ?? ""
        bind()
    }
    
    func bind() {
        let input = EmailViewModel.Input(email: mainView.emailTextField.rx.text, tap: mainView.button.rx.tap)
        
        let output = viewModel.transform(input: input)

        output.validStatus
            .drive(mainView.button.rx.status)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .bind { _ in
                self.resignFirstResponder()
                if self.mainView.button.status == .fill {
                    UserManager.email = self.mainView.emailTextField.text
                    self.navigationController?.pushViewController(GenderViewController(), animated: true)
                } else {
                    self.view.makeToast("이메일 형식이 올바르지 않습니다.")
                }
            }
            .disposed(by: disposeBag)
        
        //        output.validStatus
        //            .asDriver(onErrorJustReturn: false)
        //
        //            .drive(mainView.button.rx.isEnabled)
        //            .disposed(by: disposeBag)
    }
}
