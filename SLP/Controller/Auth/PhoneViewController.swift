//
//  ViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/18.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

final class PhoneViewController: UIViewController {
    
    

    var viewModel = PhoneViewModel()
    var mainView = PhoneView()
    var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        mainView.button.setTitle("인증 문자 받기", for: .normal)
        mainView.titleLabel.text = viewModel.title
        mainView.phoneTextField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        bind()
        
    }
    
    func bind(){
        let input = PhoneViewModel.Input(phoneNumber: mainView.phoneTextField.rx.text, tap: mainView.button.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: mainView.button.rx.validStatus)
            .disposed(by: disposeBag)
        
        
        
        output.sceneTransition
            .subscribe { _ in
                
                //
                Auth.auth().languageCode = "kr"
                
                guard let phoneNumber = self.mainView.phoneTextField.text else {
                    return
                }
                
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verifyID, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    self.mainView.currentVerification = verifyID!
                    UserDefaults.standard.set(self.mainView.currentVerification, forKey: "authVerificationID")
                    UserDefaults.standard.set(self.mainView.phoneTextField.text, forKey: "phoneNumber")
                }
                self.navigationController?.pushViewController(VerifyViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    
    
}


