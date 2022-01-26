//
//  UIFont+Extension.swift
//  SLP
//
//  Created by Kanghos on 2022/01/19.
//

import UIKit

extension UIFont {
    enum Family: String {
        case Regular = "NotoSansKR-Regular"
        case Medium = "NotoSansKR-Medium"
    }
    static let Display1_R20 = UIFont(name: Family.Regular.rawValue, size: 20)
    static let Title1_M16 = UIFont(name: Family.Medium.rawValue, size: 16)
    static let Title2_R16 = UIFont(name: Family.Regular.rawValue, size: 16)
    static let Title3_M14 = UIFont(name: Family.Medium.rawValue, size: 14)
    static let Title4_R14 = UIFont(name: Family.Regular.rawValue, size: 14)
    static let Title5_M12 = UIFont(name: Family.Medium.rawValue, size: 12)
    static let Title6_R12 = UIFont(name: Family.Regular.rawValue, size: 12)
    static let Body1_M16 = UIFont(name: Family.Medium.rawValue, size: 16)
    static let Body2_R16 = UIFont(name: Family.Regular.rawValue, size: 16)
    static let Body3_R14 = UIFont(name: Family.Regular.rawValue, size: 14)
    static let Body4_R12 = UIFont(name: Family.Regular.rawValue, size: 12)
    static let caption_R10 = UIFont(name: Family.Regular.rawValue, size: 10)
}
