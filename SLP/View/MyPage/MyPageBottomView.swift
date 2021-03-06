//
//  ProfileDetailBottomView.swift
//  SeSAC_Friends
//
//  Created by kokojong on 2022/01/27.
//

import UIKit
import Then
import RangeSeekSlider

final class MyPageBottomView: UIView, ViewRepresentable {
    
    let nameLabel = UILabel().then {
        $0.text = "내 성별"
        $0.font = .Title4_R14
    }
    
    let manButton = GreenButton().then {
        $0.titleLabel?.font = .Title4_R14
        $0.setTitle("남자", for: .normal)
    }
    
    let womanButton = GreenButton().then {
        
        $0.setTitle("여자", for: .normal)
    }
    
    let hobbyLabel = UILabel().then {
        $0.text = "자주 하는 취미"
        $0.font = .Title4_R14
    }
    
    let hobbyTextField = UITextField().then {
        $0.textColor = .black
        $0.font = .Title4_R14
        $0.placeholder = "취미를 입력해 주세요"
        
    }
    
    let underline = UIView().then {
        $0.backgroundColor = .gray3
    }

    let allowSearchLabel = UILabel().then {
        $0.text = "내 번호 검색 허용"
        $0.font = .Title4_R14
    }
    
    let allowSearchSwitch = UISwitch().then {
        $0.thumbTintColor = .white
        $0.onTintColor = .brandGreen
    }
    
    let ageTextLabel = UILabel().then {
        $0.font = .Title4_R14
        $0.text = "상대방 연령대"
    }
    
    let ageRangeLabel = UILabel().then {
        $0.font = .Title3_M14
        $0.text = "18 - 65"
        $0.textColor = .brandGreen
    }
    
    let ageSlider = RangeSeekSlider().then {
        $0.minValue = 18
        $0.maxValue = 65
        $0.enableStep = true
        $0.step = 1
        $0.handleColor = .brandGreen
        $0.colorBetweenHandles = .brandGreen
        $0.tintColor = .gray2
        $0.hideLabels = true

    }
      
    let withDrawLabel = UILabel().then {
        $0.text = "회원 탈퇴"
        $0.font = .Title4_R14
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        addSubview(nameLabel)
        addSubview(manButton)
        addSubview(womanButton)
        addSubview(hobbyLabel)
        addSubview(hobbyTextField)
        addSubview(underline)
        addSubview(allowSearchLabel)
        addSubview(allowSearchSwitch)
        addSubview(ageTextLabel)
        addSubview(ageRangeLabel)
        addSubview(ageSlider)
        addSubview(withDrawLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(womanButton)
            make.trailing.equalTo(manButton.snp.leading).offset(8)
            make.height.equalTo(48)
        }
        
        manButton.snp.makeConstraints { make in
            make.trailing.equalTo(womanButton.snp.leading).inset(-8)
            make.top.equalTo(womanButton)
            make.width.equalTo(56)
            make.height.equalTo(48)
        }
        
        womanButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(28)
            make.width.equalTo(56)
            make.height.equalTo(48)
        }
        
        hobbyLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(hobbyTextField.snp.leading).offset(8)
            make.height.equalTo(48)
        }
        
        hobbyTextField.snp.makeConstraints { make in
            make.top.equalTo(hobbyLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(48)
        }
        
        underline.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(hobbyTextField)
            make.height.equalTo(1)
        }
        
        allowSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(hobbyLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(allowSearchSwitch.snp.leading).offset(8)
            make.height.equalTo(48)
//            make.bottom.equalToSuperview()
        }
        
        allowSearchSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(allowSearchLabel)
            make.trailing.equalToSuperview()
            make.height.equalTo(28)
            make.width.equalTo(52)
        }
        
        ageTextLabel.snp.makeConstraints { make in
            make.top.equalTo(allowSearchLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(ageRangeLabel.snp.leading).offset(8)
            make.height.equalTo(48)
            
        }
        
        ageRangeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ageTextLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(50)
        }
        
        ageSlider.snp.makeConstraints { make in
            make.top.equalTo(ageTextLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
            
        }
        
        withDrawLabel.snp.makeConstraints { make in
            make.top.equalTo(ageSlider.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure() {
        
    }
   
}
