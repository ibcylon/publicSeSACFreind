//
//  UIButton+Extension.swift
//  SLP
//
//  Created by Kanghos on 2022/01/23.
//

import UIKit

extension UIButton.Configuration {
    public static func disableStyle() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.backgroundColor = .gray6
        style.background = background
        return style
    }
    
    public static func fillStyle() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.backgroundColor = .brandGreen
        style.background = background
        return style
    }
    
    
}


