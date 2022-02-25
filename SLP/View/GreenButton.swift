//
//  GreenButton.swift
//  SLP
//
//  Created by Kanghos on 2022/01/19.
//

import UIKit
import SnapKit

 enum ButtonStatus {
    case inactive, fill, outline, cancel, disable
}

final class GreenButton: UIButton {
    
    var status: ButtonStatus = .fill {
        didSet {
            switch status {
            case .inactive:
                self.configuration = .fillStyle()
            case .fill:
                self.configuration = .fillStyle()
            case .outline:
                self.configuration = .disableStyle()
            case .cancel:
                self.configuration = .disableStyle()
            case .disable:
                self.configuration = .disableStyle()
            }
        }
    }
    
    var validStatus: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.status = .fill
        backgroundColor = .brandGreen
        self.layer.cornerRadius = 10
        
        self.configuration = .disableStyle()
        setTitleColor(.white, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFillStyle() {
        
    }
    
}

extension GreenButton {
    
}
