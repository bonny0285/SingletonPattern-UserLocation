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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        zoomStep.isHidden = true
//        zoomLabel.isHidden = true
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
        
        MyUserLocation.shared.myMap = userMap
        MyUserLocation.shared.checkLocationServices(forMapView: userMap,forAltitudeMeter: zoomStep.value,forLongitudeMeter: zoomStep.value)
        
//        zoomStep.isHidden = false
//        zoomLabel.isHidden = false
        zoomStack.isHidden = false
    }
    
    
    
    @IBAction func ZoomStepper(_ sender: UIStepper) {
        print(zoomStep.value)
        MyUserLocation.shared.altitudeMeter = zoomStep.stepValue
        MyUserLocation.shared.longitudeMeter = zoomStep.stepValue
        MyUserLocation.shared.checkLocationServices(forMapView: userMap,forAltitudeMeter: zoomStep.value,forLongitudeMeter: zoomStep.value)
  
    }
    
    
}

