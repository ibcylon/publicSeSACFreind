//
//  GreenCell.swift
//  SLP
//
//  Created by Kanghos on 2022/02/08.
//

import UIKit

enum CellStatus {
    case focus
}

final class GreenCell: UICollectionViewCell, ViewRepresentable {
    
    static let identifier = "GreenCell"
    
    let textLabel = UILabel()

    required init?(coder: NSCoder) {
        fatalError("not impl")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupConstraints()
    }
    
    func configure() {
        self.layer.borderColor = UIColor.brandGreen?.cgColor
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        
        textLabel.textAlignment = .center
        textLabel.textColor = .brandGreen
    }
    
    func setupConstraints() {
        addSubview(textLabel)
        
    }
}
