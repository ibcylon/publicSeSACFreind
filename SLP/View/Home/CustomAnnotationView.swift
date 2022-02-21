//
//  CustomAnnotationView.swift
//  SLP
//
//  Created by Kanghos on 2022/02/13.
//

import Foundation
import MapKit

enum CustomAnnotationImage: Int {
    case normal = 1
    case strong = 2
    case mint = 3
    case purple = 4
    case gold = 5
}

extension CustomAnnotationImage {
    var imageName: String {
        let baseName = "sesac_face_"
        return baseName + "\(CustomAnnotationImage.RawValue.self)"
    }
}

final class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CustomAnnotation: NSObject, MKAnnotation {
    let sesac_image: Int?
    let coordinate: CLLocationCoordinate2D
    
    init(sesac_image: Int?, coordinate: CLLocationCoordinate2D) {
        self.sesac_image = sesac_image
        self.coordinate = coordinate
        super.init()
    }
}
