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
    
    func bind(){
        
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
            .bind { _ in
                print(self.viewModel.selectedGender)
                UserDefaults.standard.set(self.viewModel.selectedGender.rawValue, forKey: "gender")
                
                self.viewModel.login { code, error in
 

                    guard let code = code else {
                        return
                    }
                    print(code)
                    switch code {
                    case 200:
                        
                        self.navigationController?.pushViewController(MainViewController(), animated: true)
                        
                    default:
                        print("error")
                    }

                }
                
                
            }
            .disposed(by: disposeBag)
    }
}
