//
//  GreenButton.swift
//  SLP
//
//  Created by Kanghos on 2022/01/19.
//

import UIKit
import SnapKit

class GreenButton: UIButton {
    
    enum buttonStatus {
        case inactive, fill, outline, cancel, disable
    }
    
    var status: buttonStatus = .disable
    var validStatus:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .brandGreen
        self.layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFillStyle(){
        
    }
    
}

extension GreenButton {
    
}
