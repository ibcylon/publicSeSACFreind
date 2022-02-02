//
//  LoginView.swift
//  SLP
//
//  Created by Kanghos on 2022/01/19.
//

import UIKit
import SnapKit

class EmailView: UIView, ViewRepresentable {
    
    let button = GreenButton()
    let titleLabel = UILabel()
    let emailTextField = UITextField()
    let descriptionLabel = UILabel()
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
        addSubview(emailTextField)
        addSubview(descriptionLabel)
        backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.Display1_R20
        button.backgroundColor = .brandGreen
        
        emailTextField.becomeFirstResponder()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(185)
            make.centerX.equalToSuperview()
            //make.height.equalTo(100)
            
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(310)
            make.leading.equalTo(10)
            make.height.equalTo(20)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
    }
    
    
    
}
