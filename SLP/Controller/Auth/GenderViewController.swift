//
//  NicknameViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import UIKit
import RxCocoa
import RxSwift

final class GenderViewController: UIViewController, BaseController {

    var viewModel = GenderViewModel()
    var mainView = GenderView()
    var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.titleLabel.text = viewModel.title
        mainView.descriptionLabel.text = viewModel.description
        
        bind()
    }
    
    func bind() {
        
        let input = GenderViewModel.Input(maletap: self.mainView.maleButton.rx.tap, femaletap: self.mainView.femaleButton.rx.tap, tap: self.mainView.button.rx.tap)
        let output = viewModel.transform(input: input)

        output.maleState
            .asDriver(onErrorJustReturn: false)
            .drive(mainView.maleButton.rx.isSelected)
            .disposed(by: disposeBag)

        output.femaleState
            .asDriver(onErrorJustReturn: false)
            .drive(mainView.femaleButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .bind {  _ in
                
                UserManager.gender = self.viewModel.gender.value.rawValue

                self.recursiveLogin()

            }
            .disposed(by: disposeBag)
    }

    func recursiveLogin() {
        self.viewModel.register { statusCode in
            switch statusCode {
            case .registerSuccess:
                self.view.makeToast(statusCode?.message)

                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            case .existedUser:
                self.view.makeToast(statusCode?.message)
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            case .invalidNickname:
                self.view.makeToast(statusCode?.message)
                self.navigationController?.pushViewController(NicknameViewController(), animated: true)
            case .invalidToken:
                FirebaseAPI.refreshToken()
                self.recursiveLogin()
            default :
                print(statusCode?.message ?? "")
            }
        }
    }
}
