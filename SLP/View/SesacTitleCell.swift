//
//  SesacTitleCell.swift
//  SLP
//
//  Created by Kanghos on 2022/02/16.
//

import UIKit

class SesacTitleCell: UICollectionViewCell, ViewRepresentable {

    let badge = GreenButton()
    
    static let identifier = "SesacTitleCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        badge.configuration = .disableStyle()
        badge.configuration?.title = ""
    }
    
    func setupConstraints() {
        addSubview(badge)
        badge.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
