//
//  Capital.swift
//  Project16
//
//  Created by Андрей Гавриков on 09.01.2022.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.info = info
        self.title = title
        self.coordinate = coordinate
    }

}
