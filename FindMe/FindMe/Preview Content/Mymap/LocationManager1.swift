//
//  LocationManager.swift
//  FindMe
//
//  Created by deathot on 12/23/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager
    
    @Published var location: CLLocation?

    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        
        // Request autho
        self.locationManager.requestWhenInUseAuthorization()
        
        // Check state
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            // Update every 10m
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        } else {
            print("Can's use")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.location = newLocation
        print("Update Location: \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Get Location failed: \(error.localizedDescription)")
    }

    // Check state change
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location permission error")
        case .notDetermined:
            print("Location permission unsure")
        default:
            break
        }
    }
}


