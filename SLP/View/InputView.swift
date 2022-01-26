//
//  InputView.swift
//  SLP
//
//  Created by Kanghos on 2022/01/23.
//

import UIKit
import SnapKit

class InputView:UITextField {

    enum FieldStatus {
        case inactive, focus, active, disable, error, success
    }

    let textField = UITextField()
    var statusBar = UIView()
    var currentStatus: FieldStatus = .inactive
    var type:FieldStatus = .inactive
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(){
        delegate = self
        statusBar = UIView(frame: .zero)
        statusBar.backgroundColor = .black
    }
    
    func setStatusBar(){
        statusBar.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.trailing.equalTo(textField)
        }
    }
    
    


}

extension InputView: UITextFieldDelegate {

}
