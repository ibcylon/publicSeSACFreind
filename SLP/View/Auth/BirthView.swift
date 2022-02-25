//
//  LoginView.swift
//  SLP
//
//  Created by Kanghos on 2022/01/19.
//

import UIKit
import SnapKit

final class BirthView: UIView, ViewRepresentable {
    
    let button = GreenButton()
    let titleLabel = UILabel()
    let yearTextField = UITextField()
    let yearLabel = UILabel()
    let monthTextField = UITextField()
    let monthLabel = UILabel()
    let dayTextField = UITextField()
    let dayLabel = UILabel()
    let stackView = UIStackView()
    let datePicker = UIDatePicker()
    
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
        addSubview(stackView)
        [yearTextField, yearLabel, monthTextField, monthLabel, dayTextField, dayLabel].forEach { stackView.addArrangedSubview($0) }
        backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.Display1_R20
        yearTextField.placeholder = "1990"
        yearTextField.textAlignment = .center
        yearLabel.text = "년"
        monthLabel.text = "월"
        monthTextField.placeholder = "1"
        
        monthTextField.textAlignment = .center
        dayLabel.text = "일"
        dayTextField.placeholder = "1"
        
        dayTextField.textAlignment = .center
        
        stackView.axis = .horizontal
        stackView.spacing = 30
        
        datePicker.datePickerMode = .date
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-kr")
        yearTextField.inputView = datePicker
        monthTextField.inputView = datePicker
        dayTextField.inputView = datePicker

    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(185)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(310)
            make.height.equalTo(40)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
    }
}
