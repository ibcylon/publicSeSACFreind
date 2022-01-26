//
//  Util.swift
//  SLP
//
//  Created by Kanghos on 2022/01/24.
//

import Foundation
import UIKit

extension DateFormatter {
    
    
}

extension UIViewController {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension UILabel {
    static func titleLabel() -> UILabel {
        let title: UILabel = UILabel()
        title.font = .Display1_R20
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }
    
    static func descriptionLabel() -> UILabel {
        let description: UILabel = UILabel()
        description.font = .Title2_R16
        description.textColor = .gray7
        description.textAlignment = .center
        return description
    }
}
