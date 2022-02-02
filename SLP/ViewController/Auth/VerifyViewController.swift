//
//  ViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/18.
//

import UIKit
import RxSwift
import FirebaseAuth

class VerifyViewController: UIViewController {
    
    var viewModel = VerifyViewModel()
    let mainView = VerifyView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        mainView.button.setTitle("인증하고 시작하기", for: .normal)
        mainView.titleLabel.text = viewModel.title
        mainView.VerifyTextField.placeholder = "인증번호 입력"
        bind()
        
    }
    
    func bind(){
        let input = VerifyViewModel.Input(validNumber: mainView.VerifyTextField.rx.text, tap: mainView.button.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: mainView.button.rx.validStatus)
            .disposed(by: disposeBag)
        
        
        
        output.sceneTransition
            .subscribe { _ in
                
                guard let verificationCode = self.mainView.VerifyTextField.text, !verificationCode.isEmpty else { return }
                guard let authID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
                
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: authID, verificationCode: verificationCode)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        let authError = error as NSError
                        print(authError.description)
                        return
                    }
                }
                
                let currentUserInstance = Auth.auth().currentUser
                currentUserInstance?.getIDTokenForcingRefresh(true, completion: { idToken, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    UserDefaults.standard.set(idToken, forKey: "idToken")
                    print(UserDefaults.standard.string(forKey: "idToken")!)
                })
                self.navigationController?.pushViewController(NicknameViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }

}


