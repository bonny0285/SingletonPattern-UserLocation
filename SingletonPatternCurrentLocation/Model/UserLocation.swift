//
//  UserLocation.swift
//  SingletonPatternCurrentLocation
//
//  Created by Massimiliano on 14/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class MyUserLocation: NSObject, CLLocationManagerDelegate {

    
    
    static let shared = MyUserLocation()
    
    var myMap: MKMapView!
    
    var altitudeMeter: Double = 1000
    var longitudeMeter: Double = 1000
    
    private let locationManager = CLLocationManager()
    
    
    override init() {}
    
    
    func checkLocationServices(forMapView mapView: MKMapView,forAltitudeMeter altitude : Double,forLongitudeMeter longitude : Double){
        print(#function)
        if CLLocationManager.locationServicesEnabled(){
            //Setup our Location Manager
            setupLocationManager()
            checkLocationAuthorization(forMapView: mapView,forAltitudeMeter: altitude, forLongitudeMeter: longitude)
        } else {
            //Show alert Error
        }
    }
    
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationAuthorization(forMapView mapView: MKMapView,forAltitudeMeter altitude : Double,forLongitudeMeter longitude : Double){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            // Do Map Stuff
            mapView.showsUserLocation = true
            centerViewOnUserLocation(forMapView: mapView,forAltitudeMeter: altitude,forLongitudeMeter: longitude)
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Inform User how turn on location
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Inform User how turn on location
            break
        @unknown default:
            fatalError()
        }
    }
    
    
    
    func centerViewOnUserLocation(forMapView mapView: MKMapView,forAltitudeMeter altitude : Double,forLongitudeMeter longitude : Double){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: altitude, longitudinalMeters: longitude)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //When the authorization will change
        checkLocationAuthorization(forMapView: myMap,forAltitudeMeter: altitudeMeter,forLongitudeMeter: longitudeMeter)
    }
}
