//
//  UserPin.swift
//  Networking
//
//  Created by RomaDUlbich on 8/11/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import Foundation
import MapKit
class UserPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    var title: String?
    init(coordinate:CLLocationCoordinate2D ,subtitle:String ,title: String) {
        self.coordinate = coordinate
        self.subtitle = subtitle
        self.title = title
    }
    
}
