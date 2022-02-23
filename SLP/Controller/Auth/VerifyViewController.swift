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
                        
                        FirebaseAPI.refreshToken()
                        self.recursiveLogin()
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

    func recursiveLogin() {
        self.viewModel.login { statusCode, _ in
            switch statusCode {
            case 200:
                Storage.setCurrentState(scene: Scene.main)
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(Storage.currentState())
            case 401:
                FirebaseAPI.refreshToken()
                self.recursiveLogin()
            case 406:
                Storage.setCurrentState(scene: Scene.email)
                self.navigationController?.pushViewController(NicknameViewController(), animated: true)
            case 500:
                self.view.makeToast("잠시 후 다시 해보시기 바랍니다.")
            case 501:
                print("프론트 체크")
            default:
                print("unknownError", statusCode as Any)
            }
        }
    }
}
