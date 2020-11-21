//
//  LocationFetcher.swift
//  LocalStars
//
//  Created by Michal Tuszynski on 21/11/2020.
//

import Foundation
import CoreLocation

final class LocationFetcher: NSObject {
    static let `default` = LocationFetcher()

    private let locationManager = CLLocationManager()
    private(set) var currentLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    func requestPermissions() {
        locationManager.requestWhenInUseAuthorization()
    }
}


extension LocationFetcher: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            DispatchQueue.main.async {
                self.currentLocation = locations.last
            }
        }
    }
}
