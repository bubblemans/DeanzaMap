//
//  AnnotationPin.swift
//  DeanzaMap
//
//  Created by Alvin Lin on 13/03/2018.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import MapKit

class AnnotationPin: NSObject, MKAnnotation{
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
