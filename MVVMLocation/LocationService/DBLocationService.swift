//
//  DBLocationService.swift
//  MVVMLocation
//
//  Created by Vinu Murugan on 06/03/21.
//

import Foundation
import UIKit
import CoreLocation

class DBLocationService : NSObject {
    
    public static var shared = DBLocationService()
    var locationManager = CLLocationManager()
    var getLocationChangeDetails : ((_ cbLocation:DBLocation) -> Void)?
    var latestLocation : CLLocation?
    var lastTime : Date = Date().adding(minutes: -10)
    
    func startUpdateLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func stopUpdateLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.allowsBackgroundLocationUpdates = false
    }
}


extension DBLocationService : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.latestLocation = location
            print("Found user's location: \(location)")
            if let locationCompletion = getLocationChangeDetails , self.lastTime.adding(minutes: 10) <= Date(){
                locationCompletion(DBLocation.init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, sutiation: "Update"))
                self.lastTime = Date()
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .notDetermined {
            // location can fetch while app in background too
            locationManager.requestWhenInUseAuthorization()
        } else if locationManager.authorizationStatus == .authorizedWhenInUse {
            // location can fetch while app in foregorund too
            locationManager.requestWhenInUseAuthorization()
        } else if locationManager.authorizationStatus == .authorizedAlways {
            // location can fetch while app in background too
        } else if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
            DBAlertService.showAlert(WithMessage: "Location service is disabled. Please click ok to route to location setting") { () -> (Void) in
                if let url = URL(string:UIApplication.openSettingsURLString) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }

    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
    }

    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

}
