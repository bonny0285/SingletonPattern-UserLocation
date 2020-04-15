//
//  ViewController.swift
//  SingletonPatternCurrentLocation
//
//  Created by Massimiliano on 14/04/2020.
//  Copyright © 2020 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    
    @IBOutlet weak var userMap: MKMapView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var zoomStep: UIStepper!
    @IBOutlet weak var zoomLabel: UILabel!
    @IBOutlet weak var zoomStack: UIStackView!
    
    
    var instance = MyUserLocation.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        zoomStack.isHidden = true
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        userMap.delegate = self
        
        zoomStep.value = 1000
        zoomStep.minimumValue = 0
        zoomStep.maximumValue = 100000
        zoomStep.stepValue = 200
        
        

    }

    @IBAction func checkUserLocationButtonWasPressed(_ sender: UIButton) {
        
        instance.myMap = userMap
        instance.checkLocationServices(forMapView: userMap, forAltitudeMeter: instance.altitudeMeter, forLongitudeMeter: instance.longitudeMeter)
        
        

        zoomStack.isHidden = false
    }
    
    
    
    @IBAction func ZoomStepper(_ sender: UIStepper) {
        print(zoomStep.value)
        
        instance.altitudeMeter = zoomStep.stepValue
        instance.longitudeMeter = zoomStep.stepValue
        instance.checkLocationServices(forMapView: userMap, forAltitudeMeter: zoomStep.value, forLongitudeMeter: zoomStep.value)
        
  
    }
    
    
}

