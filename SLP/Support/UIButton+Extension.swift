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
        style.title = "다음"
        style.baseForegroundColor = .gray3
        
        return style
    }
    
    public static func fillStyle() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.backgroundColor = .brandGreen
        style.background = background
        style.title = "다음"
        style.baseForegroundColor = .white
        return style
    }
    
    public static func genderStyle() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        background.backgroundColor = .white
        background.strokeColor = .gray3
        background.strokeWidth = 1
        style.background = background
        style.baseForegroundColor = .black
        style.imagePlacement = .top
        style.titleAlignment = .center
        style.cornerStyle = .small
        style.imagePadding = 5
        
        return style
    }
    
    //질문 이건 왜 buttonConfiguration과 다르게 메소드 호출하면 오류가 날까?
    public static func setGenderHandler() -> UIButton.ConfigurationUpdateHandler {
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .selected :
                button.configuration?.background.backgroundColor = .brandWhitegreen
            default:
                button.configuration?.background.backgroundColor = .white
            }
        }
        return handler
    }
    
    
}

