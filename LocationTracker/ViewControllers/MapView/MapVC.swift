//
//  MapVC.swift
//  LocationTracker
//
//  Created by Sagar Gupta on 18/04/20.
//  Copyright © 2020 Sagar Gupta. All rights reserved.
//

import UIKit
import MapKit
class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let newPin = MKPointAnnotation()
    var locationManager:LocationManager?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mapView.delegate = self
        // Location manager intialization
        locationManager =  LocationManager.shared
        locationManager?.delegate = self
        navigationItem.hidesBackButton = true;
        //start location update
        locationManager?.locationManager.startUpdatingLocation()
        
    }
    
}
extension MapVC:MKMapViewDelegate{
    
    //MARK: - Mapview delegate methods for creating overlay circle

    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let circelOverLay = overlay as? MKCircle else {return MKOverlayRenderer()}
        let circleRenderer = MKCircleRenderer(circle: circelOverLay)
        circleRenderer.strokeColor = .blue
        circleRenderer.fillColor = .blue
        circleRenderer.alpha = 0.2
        return circleRenderer
    }
}
extension MapVC:LocationManagerDelegate{
    
    //MARK: - Delegate to get the current user location

    func userCurrentLocation(location: CLLocationCoordinate2D) {
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        //set pin on the map
        mapView.setRegion(region, animated: true)
        newPin.coordinate = location
        mapView.addAnnotation(newPin)
        // adding 100 km radius circle
    
        mapView.removeOverlays(mapView.overlays)
        mapView.addOverlay(MKCircle(center: location, radius: CLLocationDistance(100)))
        
        
    }
}
