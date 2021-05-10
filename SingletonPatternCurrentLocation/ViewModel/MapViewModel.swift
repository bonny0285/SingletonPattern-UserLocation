//
//  MapViewModel.swift
//  SingletonPatternCurrentLocation
//
//  Created by Bonafede Massimiliano on 06/05/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel {
    
    var userLocation = MyUserLocation.shared
   
    func setMap(_ map: MKMapView) {
        userLocation.myMap = map
    }

    func updateZoomOnUserLocationForValue(_ value: Double) {
        userLocation.centerViewOnUserLocationssss(forAltitudeMeter: value, forLongitudeMeter: value)
    }
}
