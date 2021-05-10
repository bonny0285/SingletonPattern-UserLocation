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


class MyUserLocation: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //MARK: - Properties

    static let shared = MyUserLocation()
    
    var myMap: MKMapView! {
        didSet {
            myMap.delegate = self
            checkLocationServices()
        }
    }
    
    private var altitudeMeter: Double = 1000
    private var longitudeMeter: Double = 1000
    private let locationManager = CLLocationManager()
    
    //MARK: - Lifecycle

    override init() {}
    
    //MARK: - Methods

    private func checkLocationServices(){
        guard CLLocationManager.locationServicesEnabled() == true else { return }
        
        setupLocationManager()
        checkLocationAuthorization()
    }
    
    
    private func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    private func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
   
        case .authorizedWhenInUse:
            // Do Map Stuff
            myMap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
      
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break

        default:
            print("Non hai i permessi della location")
            break
        }
    }
    
    private func centerViewOnUserLocation() {
        guard let location = locationManager.location?.coordinate else { return }
        
        let region = MKCoordinateRegion.init(
            center: location,
            latitudinalMeters: altitudeMeter,
            longitudinalMeters: longitudeMeter
        )
        
        myMap.setRegion(region, animated: true)
    }
    
    func centerViewOnUserLocationssss(forAltitudeMeter altitude : Double,forLongitudeMeter longitude : Double) {
        guard let location = locationManager.location?.coordinate else { return }
        
        altitudeMeter = altitude
        longitudeMeter = longitude
        
        
        let region = MKCoordinateRegion.init(
            center: location,
            latitudinalMeters: altitude,
            longitudinalMeters: longitude
        )
        
        myMap.setRegion(region, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //When the authorization will change
        checkLocationAuthorization()
    }
}
