//
//  BackgroundView.swift
//  SLP
//
//  Created by Kanghos on 2022/02/05.
//

import UIKit
import SnapKit

final class BackgourndView: UIView, ViewRepresentable {
    
    let backgroundImageView = UIImageView()
    let avartarImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not Impleement")
    }
    
    func configure() {
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "sesac_background_1")
        
        //alt 처리 고민해보기
        
        avartarImageView.image = UIImage(named: "sesac_face_1")
        
    }
    
    func setupConstraints() {
        addSubview(backgroundImageView)
        addSubview(avartarImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avartarImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        }
    }
    
}
