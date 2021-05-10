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
    
    //MARK: - Outlets

    @IBOutlet weak var userMap: MKMapView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var zoomStep: UIStepper!
    @IBOutlet weak var zoomLabel: UILabel!
    @IBOutlet weak var zoomStack: UIStackView!
    
    //MARK: - Properties

    private var viewModel = MapViewModel()
    private var currentZoom: Double = 0.0
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        zoomStack.isHidden = true
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
                
        zoomStep.value = 1000
        zoomStep.minimumValue = 0
        zoomStep.maximumValue = 100000
        zoomStep.wraps = false
        zoomStep.stepValue = 200
        currentZoom = zoomStep.value
    }

    //MARK: - Actions

    @IBAction func checkUserLocationButtonWasPressed(_ sender: UIButton) {
        viewModel.setMap(userMap)
        zoomStack.isHidden = false
        checkButton.isEnabled = false
    }

    @IBAction func ZoomStepper(_ sender: UIStepper) {
        
        if currentZoom > zoomStep.value {
            currentZoom += 200
        } else if currentZoom < zoomStep.value {
            currentZoom -= 200
        }
        
        if currentZoom < 200 {
            currentZoom = 200
        } else if currentZoom > 100000 {
            currentZoom = 100000
        }
        
        zoomStep.value = currentZoom
        
        viewModel.updateZoomOnUserLocationForValue(currentZoom)
    }
}

