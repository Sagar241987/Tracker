//
//  LocationManager.swift
//  LocationTracker
//
//  Created by Sagar Gupta on 17/04/20.
//  Copyright © 2020 Sagar Gupta. All rights reserved.
//

import UIKit
import CoreLocation
protocol  LocationManagerDelegate{
    func userCurrentLocation(location:CLLocationCoordinate2D)
}
class LocationManager: NSObject {
    var delegate:LocationManagerDelegate?
    let locationManager = CLLocationManager()
    let manager = LocalNotificationManager()
    var lastTimestamp: Date?
    // MARK: - Properties
    
    static let shared = LocationManager()
    
    // Initialization
    
    private override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            //property for updating location in background
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.pausesLocationUpdatesAutomatically = false
            //start updating location
            locationManager.startUpdatingLocation()
        }
        manager.requestPermission()
        
    }
    
    func setNotification(location:Location) -> Void {
           manager.scheduleNotifications(location: location)
       }
    
}

extension LocationManager:CLLocationManagerDelegate{
    
    //MARK: - location delegate methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        delegate?.userCurrentLocation(location: locValue)

        // Added logic for triggering a notification after 5 minute
        let now = Date()
        let interval = TimeInterval((lastTimestamp != nil) ? now.timeIntervalSince(lastTimestamp ?? Date()) : 0.0)
        if !(lastTimestamp != nil) || interval >= 5 * 3 {
            lastTimestamp = now
            let location = Location(id: "1", title: "Current Location Time", lat: String(format:"%.3f", locValue.latitude), long: String(format:"%.3f", locValue.longitude) , time: lastTimestamp?.dateToTimeConversion() ?? "0")
            setNotification(location: location)
            print("locations = \(locValue.latitude) \(locValue.longitude)")
           }
    }
}



