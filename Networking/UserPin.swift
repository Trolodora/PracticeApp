//
//  UserPin.swift
//  Networking
//
//  Created by RomaDUlbich on 8/11/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import Foundation
import MapKit



class UserPin: NSObject, MKAnnotation, Codable{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var radius: CLLocationDistance
    
    enum CodingKeys: String, CodingKey{
        case latitude, longitude, title, radius
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(radius, forKey: .radius)
        try container.encode(title, forKey: .title)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try values.decode(Double.self, forKey: .latitude)
        let longitude = try values.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        radius = try values.decode(Double.self, forKey: .radius)
        title = try values.decode(String.self, forKey: .title)
    }

    init(coordinate:CLLocationCoordinate2D  ,title: String, radius:CLLocationDistance) {
        self.coordinate = coordinate
        self.title = title
        self.radius = radius
    }
}
extension UserPin {
    public class func allPins() -> [UserPin] {
        guard let savedData = UserDefaults.standard.data(forKey: PreferencesKeys.savedItems) else { return [] }
        let decoder = JSONDecoder()
        if let savedPins = try? decoder.decode(Array.self, from: savedData) as [UserPin] {
            return savedPins
        }
        return []
    }
}
