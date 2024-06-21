//
//  LocationDataSource.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/11/24.
//

import Combine
import CoreLocation
import UIKit

public final class LocationDataSource: NSObject {
    private let locationManager: CLLocationManager = .init()
//    private let authorizationSubject: PassthroughSubject<CLAuthorizationStatus, Never> = .init()
//    private let locationSubject: PassthroughSubject<[CLLocation], Never> = .init()
    private let currentLocation: CLLocation = .init()
    
    override public init() {
        super.init()
        locationManager.delegate = self
    }
    
//    public func authorizationPublisher() -> AnyPublisher<CLAuthorizationStatus, Never> {
//        return Just(locationManager.authorizationStatus)
//            .merge(with: authorizationSubject)
//            .eraseToAnyPublisher()
//    }
    
//    public func locationPublisher() -> AnyPublisher<[CLLocation], Never> {
//        return locationSubject.eraseToAnyPublisher()
//        
//    }
    
    public func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
//    public func startTracking() {
//        locationManager.startUpdatingLocation()
//    }
//    
//    public func stopTracking() {
//        locationManager.stopUpdatingLocation()
//    }
}

extension LocationDataSource: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        authorizationSubject.send(manager.authorizationStatus)
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        locationSubject.send(locations)
    }
}
