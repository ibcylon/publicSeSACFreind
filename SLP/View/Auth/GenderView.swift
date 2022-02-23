//
//  LoginView.swift
//  SLP
//
//  Created by Kanghos on 2022/01/19.
//

import UIKit
import SnapKit

class GenderView: UIView, ViewRepresentable {
    
    let button = GreenButton()
    let titleLabel = UILabel.titleLabel()
    let descriptionLabel = UILabel.descriptionLabel()
    let genderContainer = UIStackView()
    let maleButton = UIButton()
    let femaleButton = UIButton()
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
        addSubview(descriptionLabel)
        addSubview(genderContainer)

        backgroundColor = .white
        
        genderContainer.axis = .horizontal
        genderContainer.spacing = 10
        genderContainer.distribution = .fillEqually
        genderContainer.alignment = .center
        
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.isSelected {
            case true:
                button.configuration?.background.backgroundColor = .brandWhitegreen
            case false:
                button.configuration?.background.backgroundColor = .white
            }
        }
        
        maleButton.configuration = .genderStyle()
        maleButton.configuration?.title = "남자"
        maleButton.configuration?.image = UIImage(named: "man")
        maleButton.configurationUpdateHandler = handler
        
        femaleButton.configuration = .genderStyle()
        femaleButton.configuration?.title = "여자"
        femaleButton.configuration?.image = UIImage(named: "woman")
        femaleButton.configurationUpdateHandler = handler
        
        [maleButton, femaleButton].forEach {
            genderContainer.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(185)
            make.centerX.equalToSuperview()
            
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            
        }
        
        genderContainer.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.height.equalTo(130)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
    }
}
