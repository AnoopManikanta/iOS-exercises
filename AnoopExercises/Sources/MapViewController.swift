//
//  MapViewController.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 10/02/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    override func loadView() {
        // creating map view
        mapView = MKMapView()
        
        // setting mapView as the view of this controller
        view = mapView
        let standard = R.string.localizable.mapViewTypeStandard(preferredLanguages: ["\(Locale.current)"])
        let hybrid = R.string.localizable.mapViewTypeHybrid(preferredLanguages: ["\(Locale.current)"])
        let satellite = R.string.localizable.mapViewTypeSatellite(preferredLanguages: ["\(Locale.current)"])
        let segmentedControl = UISegmentedControl(items: [standard, hybrid, satellite])
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        
        // disabling views to scale for different sized screens
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Map View Controller is loaded")
    }
}

