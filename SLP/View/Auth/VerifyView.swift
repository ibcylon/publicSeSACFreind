//
//  LoginView.swift
//  SLP
//
//  Created by Kanghos on 2022/01/19.
//

import UIKit
import SnapKit

class VerifyView: UIView, ViewRepresentable {
    
    let button = GreenButton()
    let titleLabel = UILabel()
    let VerifyTextField = UITextField()
    let submitButton = GreenButton()
    let descriptionLabel = UILabel()
    let timerLabel = UILabel()
    var currentVerification = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        addSubview(button)
        addSubview(titleLabel)
        addSubview(VerifyTextField)
        addSubview(submitButton)
        addSubview(descriptionLabel)
        addSubview(timerLabel)
        
        backgroundColor = .white
        
        VerifyTextField.textContentType = .oneTimeCode
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.Display1_R20
        button.backgroundColor = .brandGreen
        timerLabel.textAlignment = .center
        timerLabel.textColor = .brandGreen
        timerLabel.text = "05:00"
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(185)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            
        }
        VerifyTextField.snp.makeConstraints { make in
            make.top.equalTo(310)
            make.leading.equalTo(10)
            make.height.equalTo(20)
        }
        timerLabel.snp.makeConstraints { make in
            make.leading.equalTo(VerifyTextField.snp.trailing)
            make.height.equalTo(20)
            make.top.equalTo(VerifyTextField)
        }
        submitButton.snp.makeConstraints { make in
            make.leading.equalTo(timerLabel.snp.trailing)
            make.height.equalTo(20)
            make.top.equalTo(VerifyTextField)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
    }
    
    
    
}
