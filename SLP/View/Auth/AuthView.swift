//
//  LoginView.swift
//  SLP
//
//  Created by Kanghos on 2022/01/19.
//

import UIKit
import SnapKit

final class AuthView: UIView, ViewRepresentable {
    
    let button = GreenButton()
    let titleLabel = UILabel.titleLabel()
    let descriptionLabel = UILabel.descriptionLabel()
    let mainTextField = UITextField()
    let titleContainer = UIStackView()
    
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
        addSubview(titleContainer)
//        addSubview(titleLabel)
//        addSubview(descriptionLabel)
        addSubview(mainTextField)
        
        backgroundColor = .white
        
        titleContainer.axis = .vertical
        titleContainer.addArrangedSubview(titleLabel)
        titleContainer.addArrangedSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        
        mainTextField.snp.makeConstraints { make in
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
