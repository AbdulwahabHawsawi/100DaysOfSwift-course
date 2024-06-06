//
//  Location.swift
//  BucketList
//
//  Created by Abdulwahab Hawsawi on 04/05/2024.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable{
    var id: UUID
    var name: String
    var description: String
    let longitude: Double
    let latitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(name: "Dubai", description: "Where the tallest building is", longitude: 51.25377500, latitude:  -85.32321400)
    
    init(id: UUID = UUID(), name: String = "New Location", description: String = "", longitude: Double, latitude: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.longitude = longitude
        self.latitude = latitude
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
