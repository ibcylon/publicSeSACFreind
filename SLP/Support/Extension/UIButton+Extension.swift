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
        var container = AttributeContainer()
        container.font = .Title4_R14
        background.backgroundColor = .gray6
        style.background = background
        style.title = ""
        style.attributedTitle = AttributedString("", attributes: container)
        style.baseForegroundColor = .gray3
        
        return style
    }
    
    public static func inactiveStyle() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        var container = AttributeContainer()
        container.font = .Title6_R12
        background.backgroundColor = .white
        background.strokeColor = .gray6
        background.strokeWidth = 1
        style.background = background
        
        style.attributedTitle = AttributedString(style.title ?? "다음", attributes: container)

        style.baseForegroundColor = .black
        
        return style
    }

    public static func fillStyle() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        var container = AttributeContainer()
        container.font = .Title4_R14
        background.backgroundColor = .brandGreen
        style.cornerStyle = .fixed
        style.background = background
        style.attributedTitle = AttributedString(style.title ?? "다음", attributes: container)
        style.baseForegroundColor = .white
        return style
    }
    
    public static func genderStyle() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIButton.Configuration.plain().background
        var container = AttributeContainer()
        container.font = .Title4_R14
        background.backgroundColor = .white
        background.strokeColor = .gray3
        background.strokeWidth = 1
        style.background = background
        style.attributedTitle = AttributedString(style.title ?? "다음", attributes: container)
        style.baseForegroundColor = .black
        style.imagePlacement = .top
        style.titleAlignment = .center
        style.cornerStyle = .small
        style.imagePadding = 5
        
        return style
    }

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
