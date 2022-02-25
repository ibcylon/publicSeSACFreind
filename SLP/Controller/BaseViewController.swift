//
//  BaseViewController.swift
//  SLP
//
//  Created by Kanghos on 2022/02/15.
//

import UIKit
import RxSwift

typealias AlertAction = (UIAlertAction) -> Void
protocol AlertDisplaying {
    func displayAlert(title: String, message: String)
    func displayFailureAlert(message: String?)
    func displayAlertWithAction(title: String?, message: String?, action: AlertAction?)
}

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

protocol BaseController: AnyObject {
    associatedtype MainView
    associatedtype ViewModel
    var viewModel: ViewModel { get set }
    var mainView: MainView { get set }
    var disposeBag: DisposeBag { get set }

    func bind()
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        setLeftArrowButton()
    }
}

class BaseViewModel {}
