//
//  NicknameViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import UIKit
import RxCocoa
import RxSwift

class GenderViewController: UIViewController {
    
    var viewModel = GenderViewModel()
    let mainView = GenderView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.titleLabel.text = viewModel.title
        mainView.descriptionLabel.text = viewModel.description
        
        bind()
        
        UserDefaults.standard.set("+821089192466", forKey: "phoneNumber")

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
                print(self.viewModel.selectedGender)
                
                UserDefaults.standard.set(self.viewModel.selectedGender.rawValue, forKey: "gender")
                
                self.viewModel.login { code, _ in

                    guard let code = code else {
                        return
                    }
                    print(code)
                    switch code {
                    case 200:
                        Storage.setCurrentState(scene: Scene.main)
                        self.view.makeToast("회원가입이 완료되었습니다.")
                        self.navigationController?.pushViewController(HomeViewController(), animated: true)

                    case 201:
                        // 이미 가입한 유저
                        self.view.makeToast("이미 가입이력이 있습니다.")
                        self.navigationController?.pushViewController(HomeViewController(), animated: true)
                    case 202:
                        // 사용할 수 없는 닉네임
                        // 닉네임 변경 후 다시 회원가입 요청
                        self.view.makeToast("사용할 수 없는 닉네임입니다..")
                        self.navigationController?.pushViewController(NicknameViewController(), animated: true)
                    case 401:
                        // Firebase Token Error
                        // 토큰 갱신 코드 작성
                        APIService.refreshToken()
                        self.viewModel.login { statusCode, _ in
                            switch statusCode {
                            case 200:
                                self.view.makeToast("회원가입이 완료되었습니다.")
                                self.navigationController?.pushViewController(HomeViewController(), animated: true)
                            case 201:
                                self.view.makeToast("이미 가입이력이 있습니다.")
                                self.navigationController?.pushViewController(HomeViewController(), animated: true)
                            case 202:
                                self.view.makeToast("사용할 수 없는 닉네임입니다..")
                                self.navigationController?.pushViewController(NicknameViewController(), animated: true)
                            case 500:
                                self.view.makeToast("잠시 후에 다시 시도해주시기 바랍니다.")
                            case 501:
                                print("header")
                            default :
                                print("unknown error")
                                
                            }
                        }
                        
                    case 500:
                        // Server Error
                        self.view.makeToast("잠시 후에 다시 시도해주시기 바랍니다.")
                    case 501:
                        // Client Error
                        // API 요청시 Header와 RequestBody에 값을 빠트리지 않고 전송했는지 확인
                        print("header")
                    default :
                        print("unknown error")
                    }

                }
            }
            .disposed(by: disposeBag)
    }
}
