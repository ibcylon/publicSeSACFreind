//
//  HomeView.swift
//  SLP
//
//  Created by Kanghos on 2022/02/13.
//

import UIKit
import SnapKit
import MapKit
import Then

final class HomeView: UIView, ViewRepresentable {
    
    let mapView = MKMapView().then {
        $0.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 500, maxCenterCoordinateDistance: 3000)
    }
    
    let genderButtonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 0
    }
    
    let searchMaleButton = GreenButton().then {
        $0.configuration = .inactiveStyle()
        $0.configuration?.title = "남자"
        
        $0.tag = Gender.male.rawValue
    }
    
    let searchFemaleButton = GreenButton().then {
        $0.configuration = .inactiveStyle()
        $0.configuration?.title = "여자"
        
        $0.tag = Gender.female.rawValue
    }
    
    let searchAllButton = GreenButton().then {
        $0.configuration = .fillStyle()
        $0.configuration?.title = "전체"
        
        $0.tag = Gender.none.rawValue
    }
    
    let centerLocationView = UIImageView().then {
        $0.image = UIImage(named: "map_marker")
    }
    
    let floatingButton = UIButton().then {
        $0.setImage(UIImage(named: "shopAct"), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.frame.size.width/2
    }
    
    let myLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "gps"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .white
        
        addSubview(mapView)
        addSubview(floatingButton)
        addSubview(myLocationButton)
        addSubview(genderButtonStackView)
        addSubview(centerLocationView)
        
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.isSelected {
            case true :
                button.configuration = .fillStyle()
                button.configuration?.background.cornerRadius = .zero
            case false :
                button.configuration = .inactiveStyle()
                button.configuration?.background.strokeWidth = 0
                button.configuration?.background.cornerRadius = .zero
            }
            switch button.tag {
            case Gender.male.rawValue:
                button.configuration?.title = "남자"
                
            case Gender.female.rawValue:
                button.configuration?.title = "여자"
            case Gender.none.rawValue:
                button.configuration?.title = "전체"
            default:
                button.configuration?.title = "전체"
            }
            var container = AttributeContainer()
            container.font = .Title6_R12
            button.configuration?.attributedTitle = AttributedString(button.configuration?.title ?? "다음", attributes: container)
        }
        
        [searchAllButton, searchMaleButton, searchFemaleButton].forEach {
            genderButtonStackView.addArrangedSubview($0)
            $0.configurationUpdateHandler = handler
        }
        
        
        genderButtonStackView.layer.cornerRadius = 10
        genderButtonStackView.clipsToBounds = true
        genderButtonStackView.layer.shadowOffset = CGSize(width: 3, height: 3)
        genderButtonStackView.layer.shadowColor = UIColor.gray1?.cgColor
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            
        }
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            make.size.equalTo(64)
        }
        genderButtonStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        searchMaleButton.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.top.equalTo(genderButtonStackView.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.size.equalTo(48)
        }
        
        centerLocationView.snp.makeConstraints { make in
            make.centerX.equalTo(mapView)
            make.centerY.equalTo(mapView).offset(-24)
            make.size.equalTo(48)
        }
    }
    
}
