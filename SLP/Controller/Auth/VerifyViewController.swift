//
//  ViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/01/18.
//

import UIKit
import RxSwift
import FirebaseAuth

final class VerifyViewController: BaseViewController {
    
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
    
    func bind() {
        mainView.submitButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
        let input = VerifyViewModel.Input(validNumber: mainView.VerifyTextField.rx.text, tap: mainView.button.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .drive(mainView.button.rx.status)
            .disposed(by: disposeBag)
        
        mainView.timerLabel.rx.text.onNext("\(viewModel.second)")

        output.sceneTransition
            .bind { _ in
                self.resignFirstResponder()
                if self.mainView.button.status == .fill {
                    guard let verificationCode = self.mainView.VerifyTextField.text, !verificationCode.isEmpty
                    else { return }
                    guard let authID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
                    
                    let credential = PhoneAuthProvider.provider().credential(withVerificationID: authID, verificationCode: verificationCode)
                    
                    Auth.auth().signIn(with: credential) { _, error in
                        if let error = error {
                            let authError = error as NSError
                            print(authError.description)
                            
                            self.view.makeToast("인증에 실패하였습니다.")
                            return
                        }
                        
                        APIService.refreshToken()
                        
                        self.viewModel.login { statusCode, _ in
                            
                            switch statusCode {
                            case 200:
                                Storage.setCurrentState(scene: Scene.main)
                                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(Storage.currentState())
                            case 401:
                                // 토큰 이상함
                                print("\n\ntoken 불량\n\n")
                            case 406:
                                Storage.setCurrentState(scene: Scene.email)
                                self.navigationController?.pushViewController(NicknameViewController(), animated: true)
                            case 500:
                                print("Server Error")
                            case 501:
                                print("CLient Error")
                            default :
                                print("unknown Error")
                            }
                        }
                    }
                } else {
                    self.view.makeToast("승인번호가 올바르지 않습니다.")
                }
                
            }
            .disposed(by: disposeBag)
    }
    
    @objc func requestButtonClicked() {
        
        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")!
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verficationId, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let verficationId = verficationId else {
                    return }
                
                UserDefaults.standard.set(verficationId, forKey: "authVerificationID")
            }
    }
}
