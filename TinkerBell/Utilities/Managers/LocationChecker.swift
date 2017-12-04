//
//  LocationChecker.swift
//  TinkerBell
//
//  Created by Paul McCartney on 2017/12/03.
//  Copyright © 2017年 Satsuki Hashiba. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationChecker: NSObject {
    static let shared = LocationChecker()
    fileprivate var locationManager = CLLocationManager()
    fileprivate var isUpdating = false
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func startUpdating() {
        if isUpdating { return }
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways {
            locationManager.delegate = self
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
            isUpdating = true
        }
    }
    
    func stopUptaing() {
        locationManager.stopUpdatingLocation()
        isUpdating = false
    }
}

extension LocationChecker: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        AlarmManager.shared.sendCheerNotification()
    }
}
