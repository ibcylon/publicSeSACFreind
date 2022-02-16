//
//  Util.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//


import UIKit
import FirebaseAuth

extension DateFormatter {
    
    
}



extension UIViewController {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setLeftArrowButton() {
        let leftArrowButton = UIBarButtonItem(image: UIImage(named: "arrow"), style: .done, target: self, action: #selector(onBackArrowButtonClicked))
        leftArrowButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftArrowButton
        
    }
    @objc func onBackArrowButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    func refreshFirebaseIdToken(completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let error = error {
                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
                completion(nil, error)
                return
            }
            
            if let idToken = idToken {
                UserDefaults.standard.set(idToken, forKey: "idToken")
                completion(idToken,nil)
                
            }
            
        }
    }
    
}

extension UILabel {
    static func titleLabel() -> UILabel {
        let title: UILabel = UILabel()
        title.font = .Display1_R20
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }
    
    static func descriptionLabel() -> UILabel {
        let description: UILabel = UILabel()
        description.font = .Title2_R16
        description.textColor = .gray7
        description.textAlignment = .center
        return description
    }
}

class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}
extension UIView {
    
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }
    
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
    
}
