//
//  NicknameViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import UIKit
import RxSwift

class NicknameViewController: UIViewController {
    
    var viewModel = NicknameViewModel()
    let mainView = NicknameView()
    let disposeBag = DisposeBag()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.button.setTitle("다음", for: .normal)
        mainView.titleLabel.text = viewModel.title
        mainView.nicknameTextField.placeholder = viewModel.placeholder
        mainView.nicknameTextField.text = UserDefaults.standard.string(forKey: "nickname")
        bind()
    }
    
    func bind() {
        let input = NicknameViewModel.Input(nickname: mainView.nicknameTextField.rx.text, tap: mainView.button.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: mainView.button.rx.validStatus)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                UserDefaults.standard.set(self.mainView.nicknameTextField.text, forKey: "nickname")
                self.navigationController?.pushViewController(BirthViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
}
