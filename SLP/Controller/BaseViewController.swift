//
//  BaseViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/02/15.
//

import UIKit

typealias AlertAction = (UIAlertAction) -> Void
protocol AlertDisplaying {
    func displayAlert(title: String, message: String)
    func displayFailureAlert(message: String?)
    func displayAlertWithAction(title: String?, message: String?, action: AlertAction?)
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        setLeftArrowButton()
    }
    
//    //let mainView: T
//    let viewModel: T//
    
    
}

class BaseViewModel {}

extension AlertDisplaying where Self: UIViewController {
    
    func displayAlert(title: String, message: String) {
        displayAlert(title: title,
                     message: message,
                     actions: [UIAlertAction(title: "Ok", style: .cancel, handler: nil)])
    }
    func displayFailureAlert(message: String? = "") {
        displayAlert(title: "Error",
                     message: message?.isEmpty == true ? "Something went wrong!" : message,
                     actions: [UIAlertAction(title: "Cancel", style: .destructive, handler: nil)])
    }
    func displayAlertWithAction(title: String?, message: String?, action: AlertAction?) {
        displayAlert(title: title,
                     message: message,
                     actions: [UIAlertAction(title: "설정", style: .default, handler: action),
                               UIAlertAction(title: "취소", style: .cancel, handler: nil)])
    }
    private func displayAlert(title: String? = "", message: String? = "", actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { (action) in
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
}
