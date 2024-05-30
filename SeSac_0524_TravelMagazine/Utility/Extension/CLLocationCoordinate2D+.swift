//
//  CLLocationCoordinate2D+.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/30/24.
//

import MapKit

extension CLLocationCoordinate2D {
    static func !=(lhs: Self, rhs: Self) -> Bool {
        lhs.latitude != rhs.latitude &&
        lhs.longitude != rhs.longitude
    }
}

extension CLLocationCoordinate2D: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude
    }
}
